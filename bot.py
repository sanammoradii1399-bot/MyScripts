import logging, requests, os
from telegram import Update, InlineKeyboardButton, InlineKeyboardMarkup
from telegram.ext import Application, CommandHandler, CallbackQueryHandler, MessageHandler, ContextTypes, filters, ConversationHandler

BOT_TOKEN = "7676861862:AAFJUR7DsNk5IPRfGrLwgPN_hvDDLs07OAg"
ADMIN_ID = 8005659349
AI_API_KEY = "sk-d08dfca5510a4c3d9085c628afcb1d55"
AI_BASE_URL = "https://api.deepseek.com"
AI_MODEL = "deepseek-chat"
SYSTEM_PROMPT = "تو «کمک‌کننده» هستی، یک دستیار هوشمند، مودب و حرفه‌ای. به زبان فارسی جواب بده."
WAITING_REQUEST, CHATTING_WITH_AI = 1, 2
SEP = "━━━━━━━━━━━━━━━━━━━━"

logging.basicConfig(format="%(asctime)s - %(levelname)s - %(message)s", level=logging.INFO)

def main_menu():
    return InlineKeyboardMarkup([
        [InlineKeyboardButton("🧠 صحبت با کمک‌کننده", callback_data="chat_ai")],
        [InlineKeyboardButton("📝 ثبت درخواست", callback_data="new_request")],
        [InlineKeyboardButton("ℹ️ درباره ما", callback_data="about"), InlineKeyboardButton("📊 آمار", callback_data="stats")],
        [InlineKeyboardButton("📞 پشتیبانی", callback_data="support")]])

def back_menu():
    return InlineKeyboardMarkup([[InlineKeyboardButton("🔙 بازگشت", callback_data="back_menu")]])

async def start(update, context):
    u = update.effective_user
    await update.message.reply_text(f"<b>🏛 پیشیار | سامانه رسمی</b>\n{SEP}\n<b>خوش آمدید {u.first_name} 👋</b>", reply_markup=main_menu(), parse_mode="HTML")

async def button(update, context):
    q = update.callback_query; await q.answer(); d = q.data
    if d == "back_menu":
        await q.edit_message_text(f"<b>🏛 پیشیار</b>\n{SEP}\nمنوی اصلی", reply_markup=main_menu(), parse_mode="HTML"); return ConversationHandler.END
    elif d == "about": await q.edit_message_text(f"<b>ℹ️ درباره ما</b>\n{SEP}\nربات رسمی پیشیار", reply_markup=back_menu(), parse_mode="HTML")
    elif d == "stats": await q.edit_message_text(f"<b>📊 آمار</b>\n{SEP}\nوضعیت: آنلاین 🟢", reply_markup=back_menu(), parse_mode="HTML")
    elif d == "support": await q.edit_message_text(f"<b>📞 پشتیبانی</b>\n{SEP}\nارتباط با ادمین", reply_markup=back_menu(), parse_mode="HTML")
    elif d == "chat_ai":
        await q.edit_message_text(f"<b>🧠 کمک‌کننده</b>\n{SEP}\nسلام! هر سوالی داری بپرس.", reply_markup=back_menu(), parse_mode="HTML"); return CHATTING_WITH_AI
    elif d == "new_request":
        await q.edit_message_text(f"<b>📝 ثبت درخواست</b>\n{SEP}\nمتن درخواستت رو بفرست.", parse_mode="HTML"); return WAITING_REQUEST

async def chat_ai(update, context):
    await update.message.chat.send_action(action="typing")
    try:
        r = requests.post(f"{AI_BASE_URL}/chat/completions", headers={"Authorization": f"Bearer {AI_API_KEY}"}, json={"model": AI_MODEL, "messages": [{"role": "system", "content": SYSTEM_PROMPT}, {"role": "user", "content": update.message.text}]}, timeout=60)
        r.raise_for_status()
        await update.message.reply_text(r.json()['choices'][0]['message']['content'])
    except Exception as e:
        await update.message.reply_text("⚠️ خطا در ارتباط با هوش مصنوعی.")
    return CHATTING_WITH_AI

async def req(update, context):
    u = update.effective_user
    try: await context.bot.send_message(ADMIN_ID, f"<b>🔔 درخواست جدید از {u.first_name}</b>\n{update.message.text}", parse_mode="HTML")
    except: pass
    await update.message.reply_text(f"<b>✅ ثبت شد</b>", reply_markup=main_menu(), parse_mode="HTML"); return ConversationHandler.END

async def dummy_web(update, context):
    pass

def main():
    app = Application.builder().token(BOT_TOKEN).build()
    app.add_handler(CommandHandler("start", start))
    app.add_handler(ConversationHandler(entry_points=[CallbackQueryHandler(button, pattern="^chat_ai$")], states={CHATTING_WITH_AI: [MessageHandler(filters.TEXT & ~filters.COMMAND, chat_ai)]}, fallbacks=[CommandHandler("start", start)]))
    app.add_handler(ConversationHandler(entry_points=[CallbackQueryHandler(button, pattern="^new_request$")], states={WAITING_REQUEST: [MessageHandler(filters.TEXT & ~filters.COMMAND, req)]}, fallbacks=[CommandHandler("start", start)]))
    app.add_handler(CallbackQueryHandler(button))
    
    print("✅ ربات پیشیار راه‌اندازی شد...")
    app.run_polling()

if __name__ == "__main__": main()

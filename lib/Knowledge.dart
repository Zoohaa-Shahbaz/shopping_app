/*

🔍 Why is UserCredential used in Firebase?
When you sign in a user using Firebase — you’re not just getting the user. You’re getting a whole authentication result.

That result is stored in a UserCredential object.

✅ Think of it like this:
You go to a hotel 🏨 and give your ID.

They don’t just hand you a room key.
They give you:

🧍 Your identity (user)

🧾 A receipt (credential)

🆕 Info like: "Are you new here?"

That whole bundle is UserCredential.

So:

🔹 UserCredential = the full result of sign-in
🔸 It gives you the User + extra info
 */
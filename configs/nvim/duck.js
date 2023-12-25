const used = new Set([..."ewqhljk1/;2pdxmizosafgc".replace(/[^a-z]/g, "")]);

for (const char of "abcdefghijklmnopqrstuvwxyz")
  if (!used.has(char)) console.log(char);

{
  split($1, a, ".");
  split($2, b, ".");
  for (i = 1; i <= 4; i++)
    if (a[i] < b[i]) {
      x =-1;
      break;
    } else if (a[i] > b[i]) {
      x = 1;
      break;
    }
  print x;
}

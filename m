Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DQxlK-0000Gy-HV for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Apr 2005 18:24:18 -0700
Received: from motgate2.mot.com ([144.189.100.101])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DQxlI-0001Yw-Vo for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Apr 2005 18:24:18 -0700
Received: from az33exr01.mot.com (az33exr01.mot.com [10.64.251.231])
	by motgate2.mot.com (8.12.11/Motgate2) with ESMTP id j3S1XJUf013571
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 27 Apr 2005 18:33:19 -0700 (MST)
Received: from zch07exm05.corp.mot.com (ZCH07EXM05.corp.mot.com [200.3.1.211])
	by az33exr01.mot.com (8.13.1/8.13.0) with ESMTP id j3S1QlvL026024
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 27 Apr 2005 20:26:48 -0500 (CDT)
Message-ID: <3BCB5FB76AFFF646BCFBC02A889B64F301799B27@ZCH07EXM05.corp.mot.com>
From: Yu Dong-W4760C <W4760C@motorola.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C54B90.FBA52488"
Subject: [uml-devel] bugs in line.c and stdio_console.c
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 28 Apr 2005 09:24:12 +0800
To: user-mode-linux-devel@lists.sourceforge.net

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C54B90.FBA52488
Content-Type: text/plain

same bugs in the two files (uml-linux-2.4.26-3):
arch/um/drivers/line.c
int line_write(struct line *lines, struct tty_struct *tty, int from_user,
        const char *buf, int len)
{
 struct line *line;
 char *new;
 unsigned long flags;
 int n, err, i, ret = 0;
 
 if(tty->stopped) return 0;
 
 if(from_user){
  new = kmalloc(len, GFP_KERNEL);
  if(new == NULL)
   return(0);
  n = copy_from_user(new, buf, len);
  buf = new;
  if(n == len){
   len = -EFAULT;
   goto out_free;
  }
 
  len -= n;
 }
 
 i = minor(tty->device) - tty->driver.minor_start;
 line = &lines[i];
 
 down(&line->sem);  ========================> may cause shedule in interrrupt
 if(line->head != line->tail){
  local_irq_save(flags);
  ret += buffer_data(line, buf, len);
  err = flush_buffer(line);
  local_irq_restore(flags);
  if(err <= 0)
   goto out_up;
 }
 
 
in arch/um/drivers/stdio_console.c
static void console_write(struct console *console, const char *string, 
     unsigned len)
{
 struct line *line = &vts[console->index];
 
 if(con_init_done)
  down(&line->sem);  ========================> may cause shedule in interrrupt
 console_write_chan(&line->chan_list, string, len);
 if(con_init_done)
  up(&line->sem);
}
 
my fix is change
[w4760c@w4760c-x3 drivers]$ diff -Nru line.c line.c.old
--- line.c      2005-04-28 09:22:29.000000000 +0800
+++ line.c.old  2005-04-26 09:38:18.000000000 +0800
@@ -134,9 +134,7 @@
        i = minor(tty->device) - tty->driver.minor_start;
        line = &lines[i];
 
-       if(!in_interrupt())
-               down(&line->sem);
-
+       down(&line->sem);
        if(line->head != line->tail){
                local_irq_save(flags);
                ret += buffer_data(line, buf, len);
@@ -159,8 +157,7 @@
                        ret += buffer_data(line, buf + n, len);
        }
  out_up:
-       if(!in_interrupt())
-               up(&line->sem);
+       up(&line->sem);
 
  out_free:
        if(from_user)

 
--- stdio_console.c     2005-04-26 14:41:05.000000000 +0800
+++ stdio_console.c.bak 2005-04-26 14:33:30.000000000 +0800
@@ -188,10 +188,10 @@
 {
        struct line *line = &vts[console->index];
 
-       if(con_init_done && !in_interrupt())
+       if(con_init_done)
                down(&line->sem);
        console_write_chan(&line->chan_list, string, len);
-       if(con_init_done && !in_interrupt())
+       if(con_init_done)
                up(&line->sem);
 }
 
 
please help to confirm if it's correct?
 
best regards
Yu Dong
 
Tel: 010-65642141
Email:  w4760c@motorola.com <mailto:w4760c@motorola.com> 
PCS Beijing Design Center
Motorola(China) Electronics Ltd. 
 
 
 

------_=_NextPart_001_01C54B90.FBA52488
Content-Type: text/html
Content-Transfer-Encoding: base64

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMCBUcmFuc2l0aW9uYWwv
L0VOIj4NCjxIVE1MPjxIRUFEPg0KPE1FVEEgSFRUUC1FUVVJVj0iQ29udGVudC1UeXBlIiBDT05U
RU5UPSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9VVMtQVNDSUkiPg0KPFRJVExFPk1lc3NhZ2U8L1RJVExF
Pg0KDQo8TUVUQSBjb250ZW50PSJNU0hUTUwgNi4wMC4yODAwLjE0OTgiIG5hbWU9R0VORVJBVE9S
PjwvSEVBRD4NCjxCT0RZPg0KPERJVj48Rk9OVCBmYWNlPUFyaWFsIHNpemU9Mj48U1BBTiBjbGFz
cz02OTYwMjEzMDEtMjgwNDIwMDU+c2FtZSBidWdzIGluIHRoZSB0d28gDQpmaWxlcyAodW1sLWxp
bnV4LTIuNC4yNi0zKTo8L1NQQU4+PC9GT05UPjwvRElWPg0KPERJVj48Rk9OVCBmYWNlPUFyaWFs
IHNpemU9Mj48U1BBTiANCmNsYXNzPTY5NjAyMTMwMS0yODA0MjAwNT5hcmNoL3VtL2RyaXZlcnMv
bGluZS5jPC9TUEFOPjwvRk9OVD48L0RJVj4NCjxESVY+PEZPTlQgZmFjZT1BcmlhbCBzaXplPTI+
PFNQQU4gY2xhc3M9Njk2MDIxMzAxLTI4MDQyMDA1PmludCANCmxpbmVfd3JpdGUoc3RydWN0IGxp
bmUgKmxpbmVzLCBzdHJ1Y3QgdHR5X3N0cnVjdCAqdHR5LCBpbnQgDQpmcm9tX3VzZXIsPEJSPiZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBjb25zdCBjaGFyICpidWYs
IGludCANCmxlbik8QlI+ezxCUj4mbmJzcDtzdHJ1Y3QgbGluZSAqbGluZTs8QlI+Jm5ic3A7Y2hh
ciAqbmV3OzxCUj4mbmJzcDt1bnNpZ25lZCBsb25nIA0KZmxhZ3M7PEJSPiZuYnNwO2ludCBuLCBl
cnIsIGksIHJldCA9IDA7PC9TUEFOPjwvRk9OVD48L0RJVj4NCjxESVY+Jm5ic3A7PC9ESVY+DQo8
RElWPjxGT05UIGZhY2U9QXJpYWwgc2l6ZT0yPjxTUEFOIA0KY2xhc3M9Njk2MDIxMzAxLTI4MDQy
MDA1PiZuYnNwO2lmKHR0eS0mZ3Q7c3RvcHBlZCkgcmV0dXJuIDA7PC9TUEFOPjwvRk9OVD48L0RJ
Vj4NCjxESVY+Jm5ic3A7PC9ESVY+DQo8RElWPjxGT05UIGZhY2U9QXJpYWwgc2l6ZT0yPjxTUEFO
IA0KY2xhc3M9Njk2MDIxMzAxLTI4MDQyMDA1PiZuYnNwO2lmKGZyb21fdXNlcil7PEJSPiZuYnNw
OyZuYnNwO25ldyA9IGttYWxsb2MobGVuLCANCkdGUF9LRVJORUwpOzxCUj4mbmJzcDsmbmJzcDtp
ZihuZXcgPT0gDQpOVUxMKTxCUj4mbmJzcDsmbmJzcDsmbmJzcDtyZXR1cm4oMCk7PEJSPiZuYnNw
OyZuYnNwO24gPSBjb3B5X2Zyb21fdXNlcihuZXcsIA0KYnVmLCBsZW4pOzxCUj4mbmJzcDsmbmJz
cDtidWYgPSBuZXc7PEJSPiZuYnNwOyZuYnNwO2lmKG4gPT0gDQpsZW4pezxCUj4mbmJzcDsmbmJz
cDsmbmJzcDtsZW4gPSAtRUZBVUxUOzxCUj4mbmJzcDsmbmJzcDsmbmJzcDtnb3RvIA0Kb3V0X2Zy
ZWU7PEJSPiZuYnNwOyZuYnNwO308L1NQQU4+PC9GT05UPjwvRElWPg0KPERJVj4mbmJzcDs8L0RJ
Vj4NCjxESVY+PEZPTlQgZmFjZT1BcmlhbCBzaXplPTI+PFNQQU4gY2xhc3M9Njk2MDIxMzAxLTI4
MDQyMDA1PiZuYnNwOyZuYnNwO2xlbiAtPSANCm47PEJSPiZuYnNwO308L1NQQU4+PC9GT05UPjwv
RElWPg0KPERJVj4mbmJzcDs8L0RJVj4NCjxESVY+PEZPTlQgZmFjZT1BcmlhbCBzaXplPTI+PFNQ
QU4gY2xhc3M9Njk2MDIxMzAxLTI4MDQyMDA1PiZuYnNwO2kgPSANCm1pbm9yKHR0eS0mZ3Q7ZGV2
aWNlKSAtIHR0eS0mZ3Q7ZHJpdmVyLm1pbm9yX3N0YXJ0OzxCUj4mbmJzcDtsaW5lID0gDQomYW1w
O2xpbmVzW2ldOzwvU1BBTj48L0ZPTlQ+PC9ESVY+DQo8RElWPiZuYnNwOzwvRElWPg0KPERJVj48
Rk9OVCBmYWNlPUFyaWFsIHNpemU9Mj48U1BBTiANCmNsYXNzPTY5NjAyMTMwMS0yODA0MjAwNT4m
bmJzcDtkb3duKCZhbXA7bGluZS0mZ3Q7c2VtKTsmbmJzcDsgDQo9PT09PT09PT09PT09PT09PT09
PT09PT0mZ3Q7IG1heSBjYXVzZSZuYnNwO3NoZWR1bGUgaW4gDQppbnRlcnJydXB0PEJSPiZuYnNw
O2lmKGxpbmUtJmd0O2hlYWQgIT0gDQpsaW5lLSZndDt0YWlsKXs8QlI+Jm5ic3A7Jm5ic3A7bG9j
YWxfaXJxX3NhdmUoZmxhZ3MpOzxCUj4mbmJzcDsmbmJzcDtyZXQgKz0gDQpidWZmZXJfZGF0YShs
aW5lLCBidWYsIGxlbik7PEJSPiZuYnNwOyZuYnNwO2VyciA9IA0KZmx1c2hfYnVmZmVyKGxpbmUp
OzxCUj4mbmJzcDsmbmJzcDtsb2NhbF9pcnFfcmVzdG9yZShmbGFncyk7PEJSPiZuYnNwOyZuYnNw
O2lmKGVyciANCiZsdDs9IDApPEJSPiZuYnNwOyZuYnNwOyZuYnNwO2dvdG8gb3V0X3VwOzxCUj4m
bmJzcDt9PC9TUEFOPjwvRk9OVD48L0RJVj4NCjxESVY+PEZPTlQgZmFjZT1BcmlhbCBzaXplPTI+
PFNQQU4gDQpjbGFzcz02OTYwMjEzMDEtMjgwNDIwMDU+PC9TUEFOPjwvRk9OVD4mbmJzcDs8L0RJ
Vj4NCjxESVY+PEZPTlQgZmFjZT1BcmlhbCBzaXplPTI+PFNQQU4gDQpjbGFzcz02OTYwMjEzMDEt
MjgwNDIwMDU+PC9TUEFOPjwvRk9OVD4mbmJzcDs8L0RJVj4NCjxESVY+PEZPTlQgZmFjZT1Bcmlh
bCBzaXplPTI+PFNQQU4gY2xhc3M9Njk2MDIxMzAxLTI4MDQyMDA1PmluIDxTUEFOIA0KY2xhc3M9
Njk2MDIxMzAxLTI4MDQyMDA1PmFyY2gvdW0vZHJpdmVycy88L1NQQU4+c3RkaW9fY29uc29sZS5j
PC9TUEFOPjwvRk9OVD48L0RJVj4NCjxESVY+PEZPTlQgZmFjZT1BcmlhbCBzaXplPTI+PFNQQU4g
Y2xhc3M9Njk2MDIxMzAxLTI4MDQyMDA1PnN0YXRpYyB2b2lkIA0KY29uc29sZV93cml0ZShzdHJ1
Y3QgY29uc29sZSAqY29uc29sZSwgY29uc3QgY2hhciAqc3RyaW5nLCANCjxCUj4mbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsgdW5zaWduZWQgbGVuKTxCUj57PEJSPiZuYnNwO3N0cnVjdCBsaW5lICps
aW5lID0gDQomYW1wO3Z0c1tjb25zb2xlLSZndDtpbmRleF07PC9TUEFOPjwvRk9OVD48L0RJVj4N
CjxESVY+PEZPTlQgZmFjZT1BcmlhbCBzaXplPTI+PC9GT05UPiZuYnNwOzwvRElWPg0KPERJVj48
Rk9OVCBmYWNlPUFyaWFsIHNpemU9Mj48U1BBTiANCmNsYXNzPTY5NjAyMTMwMS0yODA0MjAwNT4m
bmJzcDtpZihjb25faW5pdF9kb25lKTxCUj4mbmJzcDsmbmJzcDtkb3duKCZhbXA7bGluZS0mZ3Q7
c2VtKTsmbmJzcDsgDQo9PT09PT09PT09PT09PT09PT09PT09PT0mZ3Q7IG1heSBjYXVzZSZuYnNw
O3NoZWR1bGUgaW4gDQppbnRlcnJydXB0PEJSPiZuYnNwO2NvbnNvbGVfd3JpdGVfY2hhbigmYW1w
O2xpbmUtJmd0O2NoYW5fbGlzdCwgc3RyaW5nLCANCmxlbik7PEJSPiZuYnNwO2lmKGNvbl9pbml0
X2RvbmUpPEJSPiZuYnNwOyZuYnNwO3VwKCZhbXA7bGluZS0mZ3Q7c2VtKTs8QlI+fTwvU1BBTj48
L0ZPTlQ+PC9ESVY+DQo8RElWPjxGT05UIGZhY2U9QXJpYWwgc2l6ZT0yPjxTUEFOIA0KY2xhc3M9
Njk2MDIxMzAxLTI4MDQyMDA1PjwvU1BBTj48L0ZPTlQ+Jm5ic3A7PC9ESVY+DQo8RElWPjxGT05U
IGZhY2U9QXJpYWwgc2l6ZT0yPjxTUEFOIGNsYXNzPTY5NjAyMTMwMS0yODA0MjAwNT5teSBmaXgg
aXMgDQpjaGFuZ2U8L1NQQU4+PC9GT05UPjwvRElWPg0KPERJVj48Rk9OVCBmYWNlPUFyaWFsIHNp
emU9Mj48U1BBTiBjbGFzcz02OTYwMjEzMDEtMjgwNDIwMDU+W3c0NzYwY0B3NDc2MGMteDMgDQpk
cml2ZXJzXSQgZGlmZiAtTnJ1IGxpbmUuYyBsaW5lLmMub2xkPEJSPi0tLSANCmxpbmUuYyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAyMDA1LTA0LTI4IDA5OjIyOjI5LjAwMDAwMDAwMCAr
MDgwMDxCUj4rKysgDQpsaW5lLmMub2xkJm5ic3A7IDIwMDUtMDQtMjYgMDk6Mzg6MTguMDAwMDAw
MDAwICswODAwPEJSPkBAIC0xMzQsOSArMTM0LDcgDQpAQDxCUj4mbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgaSA9IG1pbm9yKHR0eS0mZ3Q7ZGV2aWNlKSAtIA0KdHR5
LSZndDtkcml2ZXIubWlub3Jfc3RhcnQ7PEJSPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyBsaW5lID0gDQomYW1wO2xpbmVzW2ldOzwvU1BBTj48L0ZPTlQ+PC9ESVY+
DQo8RElWPiZuYnNwOzwvRElWPg0KPERJVj48Rk9OVCBmYWNlPUFyaWFsIHNpemU9Mj48U1BBTiAN
CmNsYXNzPTY5NjAyMTMwMS0yODA0MjAwNT4tJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7IA0KaWYoIWluX2ludGVycnVwdCgpKTxCUj4tJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7IA0KZG93bigmYW1wO2xpbmUtJmd0O3NlbSk7PEJSPi08QlI+KyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyANCmRvd24oJmFtcDtsaW5lLSZndDtzZW0pOzxCUj4mbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgDQppZihsaW5lLSZndDtoZWFkICE9
IA0KbGluZS0mZ3Q7dGFpbCl7PEJSPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAN
CmxvY2FsX2lycV9zYXZlKGZsYWdzKTs8QlI+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7IA0KcmV0ICs9IGJ1ZmZlcl9kYXRhKGxpbmUsIGJ1ZiwgbGVuKTs8QlI+QEAgLTE1OSw4ICsx
NTcsNyANCkBAPEJSPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyANCnJldCArPSBidWZmZXJfZGF0
YShsaW5lLCBidWYgKyBuLCANCmxlbik7PEJSPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyB9PEJSPiZuYnNwOyANCm91dF91cDo8QlI+LSZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyANCmlmKCFpbl9pbnRlcnJ1cHQoKSk8QlI+LSZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyANCnVwKCZhbXA7bGluZS0mZ3Q7c2VtKTs8QlI+KyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyANCnVwKCZhbXA7bGluZS0mZ3Q7c2VtKTs8L1NQQU4+
PC9GT05UPjwvRElWPg0KPERJVj4mbmJzcDs8L0RJVj4NCjxESVY+PEZPTlQgZmFjZT1BcmlhbCBz
aXplPTI+PFNQQU4gY2xhc3M9Njk2MDIxMzAxLTI4MDQyMDA1PiZuYnNwOyANCm91dF9mcmVlOjxC
Uj4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgDQppZihmcm9tX3Vz
ZXIpPEJSPjwvU1BBTj48L0ZPTlQ+PC9ESVY+DQo8RElWPjxGT05UIGZhY2U9QXJpYWwgc2l6ZT0y
PjxTUEFOIA0KY2xhc3M9Njk2MDIxMzAxLTI4MDQyMDA1PjwvU1BBTj48L0ZPTlQ+Jm5ic3A7PC9E
SVY+DQo8RElWPjxGT05UIGZhY2U9QXJpYWwgc2l6ZT0yPjxTUEFOIGNsYXNzPTY5NjAyMTMwMS0y
ODA0MjAwNT4tLS0gDQpzdGRpb19jb25zb2xlLmMmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgMjAw
NS0wNC0yNiAxNDo0MTowNS4wMDAwMDAwMDAgDQorMDgwMDxCUj4rKysgc3RkaW9fY29uc29sZS5j
LmJhayAyMDA1LTA0LTI2IDE0OjMzOjMwLjAwMDAwMDAwMCArMDgwMDxCUj5AQCANCi0xODgsMTAg
KzE4OCwxMCBAQDxCUj4mbmJzcDt7PEJSPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyANCnN0cnVjdCBsaW5lICpsaW5lID0gJmFtcDt2dHNbY29uc29sZS0mZ3Q7aW5k
ZXhdOzwvU1BBTj48L0ZPTlQ+PC9ESVY+DQo8RElWPiZuYnNwOzwvRElWPg0KPERJVj48Rk9OVCBm
YWNlPUFyaWFsIHNpemU9Mj48U1BBTiANCmNsYXNzPTY5NjAyMTMwMS0yODA0MjAwNT4tJm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGlmKGNvbl9pbml0X2RvbmUgDQomYW1wOyZh
bXA7ICFpbl9pbnRlcnJ1cHQoKSk8QlI+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyANCmlmKGNvbl9pbml0X2RvbmUpPEJSPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyANCmRvd24oJmFtcDtsaW5lLSZndDtzZW0pOzxCUj4mbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsgDQpjb25zb2xlX3dyaXRlX2NoYW4oJmFtcDtsaW5lLSZndDtj
aGFuX2xpc3QsIHN0cmluZywgDQpsZW4pOzxCUj4tJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7IGlmKGNvbl9pbml0X2RvbmUgJmFtcDsmYW1wOyANCiFpbl9pbnRlcnJ1cHQoKSk8
QlI+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyANCmlmKGNvbl9pbml0X2Rv
bmUpPEJSPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyANCnVwKCZhbXA7bGluZS0m
Z3Q7c2VtKTs8QlI+Jm5ic3A7fTwvU1BBTj48L0ZPTlQ+PC9ESVY+DQo8RElWPjxGT05UIGZhY2U9
QXJpYWwgc2l6ZT0yPjxTUEFOIA0KY2xhc3M9Njk2MDIxMzAxLTI4MDQyMDA1PjwvU1BBTj48L0ZP
TlQ+Jm5ic3A7PC9ESVY+DQo8RElWPjxGT05UIGZhY2U9QXJpYWwgc2l6ZT0yPjxTUEFOIA0KY2xh
c3M9Njk2MDIxMzAxLTI4MDQyMDA1PjwvU1BBTj48L0ZPTlQ+Jm5ic3A7PC9ESVY+DQo8RElWPjxG
T05UIGZhY2U9QXJpYWwgc2l6ZT0yPjxTUEFOIGNsYXNzPTY5NjAyMTMwMS0yODA0MjAwNT5wbGVh
c2UgaGVscCB0byANCmNvbmZpcm0gaWYgaXQncyBjb3JyZWN0PzwvRElWPjwvU1BBTj48L0ZPTlQ+
DQo8RElWPjxGT05UIGZhY2U9QXJpYWwgc2l6ZT0yPjwvRk9OVD4mbmJzcDs8L0RJVj4NCjxESVYg
YWxpZ249bGVmdD48Rk9OVCBmYWNlPUFyaWFsIHNpemU9Mj5iZXN0IHJlZ2FyZHM8L0ZPTlQ+PC9E
SVY+DQo8RElWIGFsaWduPWxlZnQ+PEZPTlQgZmFjZT1BcmlhbCBzaXplPTI+WXUgRG9uZzwvRk9O
VD48L0RJVj4NCjxESVYgYWxpZ249bGVmdD48Rk9OVCBmYWNlPUFyaWFsIHNpemU9Mj48L0ZPTlQ+
Jm5ic3A7PC9ESVY+DQo8RElWIGFsaWduPWxlZnQ+DQo8RElWIGFsaWduPWxlZnQ+PEZPTlQgZmFj
ZT1BcmlhbCBzaXplPTI+VGVsOiAwMTAtNjU2NDIxNDE8QlI+RW1haWw6Jm5ic3A7IA0KdzQ3NjBj
PEEgaHJlZj0ibWFpbHRvOnc0NzYwY0Btb3Rvcm9sYS5jb20iPkBtb3Rvcm9sYS5jb208L0E+PC9G
T05UPjwvRElWPg0KPERJVj48Rk9OVCBmYWNlPUFyaWFsIHNpemU9Mj5QQ1MgQmVpamluZyBEZXNp
Z24gQ2VudGVyPEJSPk1vdG9yb2xhKENoaW5hKSANCkVsZWN0cm9uaWNzIEx0ZC4gPC9GT05UPjwv
RElWPjwvRElWPg0KPERJViBhbGlnbj1sZWZ0PjxGT05UIGZhY2U9QXJpYWwgc2l6ZT0yPjwvRk9O
VD4mbmJzcDs8L0RJVj4NCjxESVYgYWxpZ249bGVmdD48Rk9OVCBmYWNlPUFyaWFsIHNpemU9Mj48
L0ZPTlQ+Jm5ic3A7PC9ESVY+DQo8RElWPiZuYnNwOzwvRElWPjwvQk9EWT48L0hUTUw+DQo=

------_=_NextPart_001_01C54B90.FBA52488--


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

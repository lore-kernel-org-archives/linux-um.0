Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DySnU-0000In-AO	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Jul 2005 04:13:00 -0700
Received: from motgate4.mot.com ([144.189.100.102])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1DySnS-0008SX-Ro
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Jul 2005 04:13:00 -0700
Received: from az33exr03.mot.com (az33exr03.mot.com [10.64.251.233])
	by motgate4.mot.com (8.12.11/Motgate4) with ESMTP id j6TBKMEK026925
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 29 Jul 2005 04:20:22 -0700 (MST)
Received: from zch07exm01.corp.mot.com (zch07exm01.corp.mot.com [200.3.1.220])
	by az33exr03.mot.com (8.13.1/8.13.0) with ESMTP id j6TBIZtK005958
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 29 Jul 2005 06:18:36 -0500 (CDT)
Message-ID: <AD266326EC54D9118CE700110A9E2BE205C830AA@zch07exm01.corp.mot.com>
From: Zhu Tom-a2289c <A2289c@motorola.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5942E.71C095AD"
Subject: [uml-devel] NPTL pthread_create() cannot work.
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
Date: Fri, 29 Jul 2005 19:12:44 +0800
To: user-mode-linux-devel@lists.sourceforge.net
Cc: blaisorblade@yahoo.it

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C5942E.71C095AD
Content-Type: text/plain

Dear all,
 
I am using patch  <http://www.user-mode-linux.org/~blaisorblade/patches/devel-guest/uml-2.6.12-rc4-bb-20050521-18:54/uml-2.6.12-rc4-bb-20050521-18:54.patch.bz2> uml-2.6.12-rc4-bb-20050521-18:54.patch.bz2 on kernel 2.6.12-rc4.
but found pthread_create() cannot work.
 
it seems, in copy_thread() in arch/um/kernel/process_kern.c, the ret value's setting is not correct
 
int copy_thread(int nr, unsigned long clone_flags, unsigned long sp,
  unsigned long stack_top, struct task_struct * p, 
  struct pt_regs *regs)
{
 int ret;
 
 p->thread = (struct thread_struct) INIT_THREAD;
 ret = CHOOSE_MODE_PROC(copy_thread_tt, copy_thread_skas, nr,
    clone_flags, sp, stack_top, p, regs);
 
 if (ret || !current->thread.forking)
  goto out;
 
 clear_flushed_tls(p);
 
 if (UPT_ESI(&current->thread.regs.regs) != UPT_ESI(&p->thread.regs.regs))
  printk(KERN_DEBUG "newtls_new %x,old %x\n", (unsigned int) UPT_ESI(&current->thread.regs.regs),
    (unsigned int) UPT_ESI(&p->thread.regs.regs));
 
 /*
  * Set a new TLS for the child thread?
  */
 if (clone_flags & CLONE_SETTLS) {
  struct user_desc info;
  int idx;
 
  ret = -EFAULT;
  if (copy_from_user(&info, (void __user *)UPT_ESI(&current->thread.regs.regs), sizeof(info)))
   goto out;
  ret = -EINVAL;
  if (LDT_empty(&info))
   goto out;
 
  idx = info.entry_number;
 
  set_tls_entry(p, &info, idx, 0);
 }
 
out:
 return ret;
}
 
 
I add a "ret=0;" after set_tls_entry(p, &info, idx, 0);
 
after it, pthread_create() can return correctly, but the new thread cannot be scheduled correctly.
there is always a "Segment Fault".
 
I am using libc 2.3.3 and libc 2.3.4.
 
Note:
on 2.3.2, no "Segment Fault", it looks good.
 
Has anyone had a test of NPTL on UML?
 
 
Thanks,
Tom
 
 
 
 

------_=_NextPart_001_01C5942E.71C095AD
Content-Type: text/html
Content-Transfer-Encoding: base64

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMCBUcmFuc2l0aW9uYWwv
L0VOIj4NCjxIVE1MPjxIRUFEPg0KPE1FVEEgSFRUUC1FUVVJVj0iQ29udGVudC1UeXBlIiBDT05U
RU5UPSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9dXMtYXNjaWkiPg0KDQoNCjxNRVRBIGNvbnRlbnQ9Ik1T
SFRNTCA2LjAwLjI4MDAuMTUwNSIgbmFtZT1HRU5FUkFUT1I+PC9IRUFEPg0KPEJPRFk+DQo8RElW
PjxGT05UIGZhY2U9QXJpYWwgc2l6ZT0yPjxTUEFOIGNsYXNzPTg4MDAyNDYxMC0yOTA3MjAwNT5E
ZWFyIA0KYWxsLDwvU1BBTj48L0ZPTlQ+PC9ESVY+DQo8RElWPjxGT05UIGZhY2U9QXJpYWwgc2l6
ZT0yPjxTUEFOIA0KY2xhc3M9ODgwMDI0NjEwLTI5MDcyMDA1PjwvU1BBTj48L0ZPTlQ+Jm5ic3A7
PC9ESVY+DQo8RElWPjxGT05UIGZhY2U9QXJpYWwgc2l6ZT0yPjxTUEFOIGNsYXNzPTg4MDAyNDYx
MC0yOTA3MjAwNT5JIGFtIA0KdXNpbmcmbmJzcDtwYXRjaCA8QSANCmhyZWY9Imh0dHA6Ly93d3cu
dXNlci1tb2RlLWxpbnV4Lm9yZy9+YmxhaXNvcmJsYWRlL3BhdGNoZXMvZGV2ZWwtZ3Vlc3QvdW1s
LTIuNi4xMi1yYzQtYmItMjAwNTA1MjEtMTg6NTQvdW1sLTIuNi4xMi1yYzQtYmItMjAwNTA1MjEt
MTg6NTQucGF0Y2guYnoyIj48Rk9OVCANCnNpemU9Mz51bWwtMi42LjEyLXJjNC1iYi0yMDA1MDUy
MS0xODo1NC5wYXRjaC5iejI8L0ZPTlQ+PC9BPjxGT05UIHNpemU9Mz4gDQo8L0ZPTlQ+PEZPTlQg
c2l6ZT0yPm9uIGtlcm5lbCAyLjYuMTItcmM0LjwvRk9OVD48L1NQQU4+PC9GT05UPjwvRElWPg0K
PERJVj48Rk9OVCBmYWNlPUFyaWFsIHNpemU9Mj48U1BBTiBjbGFzcz04ODAwMjQ2MTAtMjkwNzIw
MDU+YnV0IGZvdW5kIA0KcHRocmVhZF9jcmVhdGUoKSBjYW5ub3Qgd29yay48L1NQQU4+PC9GT05U
PjwvRElWPg0KPERJVj48Rk9OVCBmYWNlPUFyaWFsIHNpemU9Mj48U1BBTiANCmNsYXNzPTg4MDAy
NDYxMC0yOTA3MjAwNT48L1NQQU4+PC9GT05UPiZuYnNwOzwvRElWPg0KPERJVj48Rk9OVCBmYWNl
PUFyaWFsIHNpemU9Mj48U1BBTiBjbGFzcz04ODAwMjQ2MTAtMjkwNzIwMDU+aXQgc2VlbXMsIGlu
IA0KY29weV90aHJlYWQoKSBpbiBhcmNoL3VtL2tlcm5lbC9wcm9jZXNzX2tlcm4uYywgdGhlIHJl
dCB2YWx1ZSdzIHNldHRpbmcgaXMgbm90IA0KY29ycmVjdDwvU1BBTj48L0ZPTlQ+PC9ESVY+DQo8
RElWPjxGT05UIGZhY2U9QXJpYWwgc2l6ZT0yPjxTUEFOIA0KY2xhc3M9ODgwMDI0NjEwLTI5MDcy
MDA1PjwvU1BBTj48L0ZPTlQ+Jm5ic3A7PC9ESVY+DQo8RElWPjxGT05UIGZhY2U9QXJpYWwgc2l6
ZT0yPjxTUEFOIGNsYXNzPTg4MDAyNDYxMC0yOTA3MjAwNT5pbnQgY29weV90aHJlYWQoaW50IA0K
bnIsIHVuc2lnbmVkIGxvbmcgY2xvbmVfZmxhZ3MsIHVuc2lnbmVkIGxvbmcgc3AsPEJSPiZuYnNw
OyZuYnNwO3Vuc2lnbmVkIGxvbmcgDQpzdGFja190b3AsIHN0cnVjdCB0YXNrX3N0cnVjdCAqIHAs
IDxCUj4mbmJzcDsmbmJzcDtzdHJ1Y3QgcHRfcmVncyANCipyZWdzKTxCUj57PEJSPiZuYnNwO2lu
dCByZXQ7PC9TUEFOPjwvRk9OVD48L0RJVj4NCjxESVY+PEZPTlQgZmFjZT1BcmlhbCBzaXplPTI+
PC9GT05UPiZuYnNwOzwvRElWPg0KPERJVj48Rk9OVCBmYWNlPUFyaWFsIHNpemU9Mj48U1BBTiBj
bGFzcz04ODAwMjQ2MTAtMjkwNzIwMDU+Jm5ic3A7cC0mZ3Q7dGhyZWFkID0gDQooc3RydWN0IHRo
cmVhZF9zdHJ1Y3QpIElOSVRfVEhSRUFEOzxCUj4mbmJzcDtyZXQgPSANCkNIT09TRV9NT0RFX1BS
T0MoY29weV90aHJlYWRfdHQsIGNvcHlfdGhyZWFkX3NrYXMsIA0KbnIsPEJSPiZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwO2Nsb25lX2ZsYWdzLCBzcCwgc3RhY2tfdG9wLCBwLCANCnJlZ3MpOzwvU1BB
Tj48L0ZPTlQ+PC9ESVY+DQo8RElWPjxGT05UIGZhY2U9QXJpYWwgc2l6ZT0yPjwvRk9OVD4mbmJz
cDs8L0RJVj4NCjxESVY+PEZPTlQgZmFjZT1BcmlhbCBzaXplPTI+PFNQQU4gY2xhc3M9ODgwMDI0
NjEwLTI5MDcyMDA1PiZuYnNwO2lmIChyZXQgfHwgDQohY3VycmVudC0mZ3Q7dGhyZWFkLmZvcmtp
bmcpPEJSPiZuYnNwOyZuYnNwO2dvdG8gb3V0OzwvU1BBTj48L0ZPTlQ+PC9ESVY+DQo8RElWPjxG
T05UIGZhY2U9QXJpYWwgc2l6ZT0yPjwvRk9OVD4mbmJzcDs8L0RJVj4NCjxESVY+PEZPTlQgZmFj
ZT1BcmlhbCBzaXplPTI+PFNQQU4gDQpjbGFzcz04ODAwMjQ2MTAtMjkwNzIwMDU+Jm5ic3A7Y2xl
YXJfZmx1c2hlZF90bHMocCk7PC9TUEFOPjwvRk9OVD48L0RJVj4NCjxESVY+PEZPTlQgZmFjZT1B
cmlhbCBzaXplPTI+PC9GT05UPiZuYnNwOzwvRElWPg0KPERJVj48Rk9OVCBmYWNlPUFyaWFsIHNp
emU9Mj48U1BBTiBjbGFzcz04ODAwMjQ2MTAtMjkwNzIwMDU+Jm5ic3A7aWYgDQooVVBUX0VTSSgm
YW1wO2N1cnJlbnQtJmd0O3RocmVhZC5yZWdzLnJlZ3MpICE9IA0KVVBUX0VTSSgmYW1wO3AtJmd0
O3RocmVhZC5yZWdzLnJlZ3MpKTxCUj4mbmJzcDsmbmJzcDtwcmludGsoS0VSTl9ERUJVRyANCiJu
ZXd0bHNfbmV3ICV4LG9sZCAleFxuIiwgKHVuc2lnbmVkIGludCkgDQpVUFRfRVNJKCZhbXA7Y3Vy
cmVudC0mZ3Q7dGhyZWFkLnJlZ3MucmVncyksPEJSPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyh1
bnNpZ25lZCANCmludCkgVVBUX0VTSSgmYW1wO3AtJmd0O3RocmVhZC5yZWdzLnJlZ3MpKTs8L1NQ
QU4+PC9GT05UPjwvRElWPg0KPERJVj48Rk9OVCBmYWNlPUFyaWFsIHNpemU9Mj48L0ZPTlQ+Jm5i
c3A7PC9ESVY+DQo8RElWPjxGT05UIGZhY2U9QXJpYWwgc2l6ZT0yPjxTUEFOIGNsYXNzPTg4MDAy
NDYxMC0yOTA3MjAwNT4mbmJzcDsvKjxCUj4mbmJzcDsgKiANClNldCBhIG5ldyBUTFMgZm9yIHRo
ZSBjaGlsZCB0aHJlYWQ/PEJSPiZuYnNwOyAqLzxCUj4mbmJzcDtpZiAoY2xvbmVfZmxhZ3MgJmFt
cDsgDQpDTE9ORV9TRVRUTFMpIHs8QlI+Jm5ic3A7Jm5ic3A7c3RydWN0IHVzZXJfZGVzYyBpbmZv
OzxCUj4mbmJzcDsmbmJzcDtpbnQgDQppZHg7PC9TUEFOPjwvRk9OVD48L0RJVj4NCjxESVY+PEZP
TlQgZmFjZT1BcmlhbCBzaXplPTI+PC9GT05UPiZuYnNwOzwvRElWPg0KPERJVj48Rk9OVCBmYWNl
PUFyaWFsIHNpemU9Mj48U1BBTiBjbGFzcz04ODAwMjQ2MTAtMjkwNzIwMDU+Jm5ic3A7Jm5ic3A7
cmV0ID0gDQotRUZBVUxUOzxCUj4mbmJzcDsmbmJzcDtpZiAoY29weV9mcm9tX3VzZXIoJmFtcDtp
bmZvLCAodm9pZCBfX3VzZXIgDQoqKVVQVF9FU0koJmFtcDtjdXJyZW50LSZndDt0aHJlYWQucmVn
cy5yZWdzKSwgDQpzaXplb2YoaW5mbykpKTxCUj4mbmJzcDsmbmJzcDsmbmJzcDtnb3RvIG91dDs8
QlI+Jm5ic3A7Jm5ic3A7cmV0ID0gDQotRUlOVkFMOzxCUj4mbmJzcDsmbmJzcDtpZiAoTERUX2Vt
cHR5KCZhbXA7aW5mbykpPEJSPiZuYnNwOyZuYnNwOyZuYnNwO2dvdG8gDQpvdXQ7PC9TUEFOPjwv
Rk9OVD48L0RJVj4NCjxESVY+PEZPTlQgZmFjZT1BcmlhbCBzaXplPTI+PC9GT05UPiZuYnNwOzwv
RElWPg0KPERJVj48Rk9OVCBmYWNlPUFyaWFsIHNpemU9Mj48U1BBTiBjbGFzcz04ODAwMjQ2MTAt
MjkwNzIwMDU+Jm5ic3A7Jm5ic3A7aWR4ID0gDQppbmZvLmVudHJ5X251bWJlcjs8L1NQQU4+PC9G
T05UPjwvRElWPg0KPERJVj48Rk9OVCBmYWNlPUFyaWFsIHNpemU9Mj48L0ZPTlQ+Jm5ic3A7PC9E
SVY+DQo8RElWPjxGT05UIGZhY2U9QXJpYWwgc2l6ZT0yPjxTUEFOIA0KY2xhc3M9ODgwMDI0NjEw
LTI5MDcyMDA1PiZuYnNwOyZuYnNwO3NldF90bHNfZW50cnkocCwgJmFtcDtpbmZvLCBpZHgsIA0K
MCk7PC9TUEFOPjwvRk9OVD48L0RJVj4NCjxESVY+PEZPTlQgZmFjZT1BcmlhbCBzaXplPTI+PFNQ
QU4gDQpjbGFzcz04ODAwMjQ2MTAtMjkwNzIwMDU+Jm5ic3A7fTwvU1BBTj48L0ZPTlQ+PC9ESVY+
DQo8RElWPjxGT05UIGZhY2U9QXJpYWwgc2l6ZT0yPjwvRk9OVD4mbmJzcDs8L0RJVj4NCjxESVY+
PEZPTlQgZmFjZT1BcmlhbCBzaXplPTI+PFNQQU4gY2xhc3M9ODgwMDI0NjEwLTI5MDcyMDA1Pm91
dDo8QlI+Jm5ic3A7cmV0dXJuIA0KcmV0OzxCUj59PC9TUEFOPjwvRk9OVD48L0RJVj4NCjxESVY+
PEZPTlQgZmFjZT1BcmlhbCBzaXplPTI+PFNQQU4gDQpjbGFzcz04ODAwMjQ2MTAtMjkwNzIwMDU+
PC9TUEFOPjwvRk9OVD4mbmJzcDs8L0RJVj4NCjxESVY+PEZPTlQgZmFjZT1BcmlhbCBzaXplPTI+
PFNQQU4gDQpjbGFzcz04ODAwMjQ2MTAtMjkwNzIwMDU+PC9TUEFOPjwvRk9OVD4mbmJzcDs8L0RJ
Vj4NCjxESVY+PEZPTlQgZmFjZT1BcmlhbCBzaXplPTI+PFNQQU4gY2xhc3M9ODgwMDI0NjEwLTI5
MDcyMDA1PkkgYWRkIGEgInJldD0wOyIgDQphZnRlciBzZXRfdGxzX2VudHJ5KHAsICZhbXA7aW5m
bywgaWR4LCAwKTs8L1NQQU4+PC9GT05UPjwvRElWPg0KPERJVj48Rk9OVCBmYWNlPUFyaWFsIHNp
emU9Mj48U1BBTiBjbGFzcz04ODAwMjQ2MTAtMjkwNzIwMDU+PC9TUEFOPjwvRk9OVD48Rk9OVCAN
CmZhY2U9QXJpYWwgc2l6ZT0yPjxTUEFOIGNsYXNzPTg4MDAyNDYxMC0yOTA3MjAwNT48L1NQQU4+
PC9GT05UPiZuYnNwOzwvRElWPg0KPERJVj48Rk9OVCBmYWNlPUFyaWFsIHNpemU9Mj48U1BBTiBj
bGFzcz04ODAwMjQ2MTAtMjkwNzIwMDU+YWZ0ZXIgaXQsIA0KcHRocmVhZF9jcmVhdGUoKSBjYW4g
cmV0dXJuIGNvcnJlY3RseSwgYnV0IHRoZSBuZXcgdGhyZWFkIGNhbm5vdCBiZSBzY2hlZHVsZWQg
DQpjb3JyZWN0bHkuPC9TUEFOPjwvRk9OVD48L0RJVj4NCjxESVY+PEZPTlQgZmFjZT1BcmlhbCBz
aXplPTI+PFNQQU4gY2xhc3M9ODgwMDI0NjEwLTI5MDcyMDA1PnRoZXJlIGlzIGFsd2F5cyBhIA0K
IlNlZ21lbnQgRmF1bHQiLjwvU1BBTj48L0ZPTlQ+PC9ESVY+DQo8RElWPjxGT05UIGZhY2U9QXJp
YWwgc2l6ZT0yPjxTUEFOIA0KY2xhc3M9ODgwMDI0NjEwLTI5MDcyMDA1PjwvU1BBTj48L0ZPTlQ+
Jm5ic3A7PC9ESVY+DQo8RElWPjxGT05UIGZhY2U9QXJpYWwgc2l6ZT0yPjxTUEFOIGNsYXNzPTg4
MDAyNDYxMC0yOTA3MjAwNT5JIGFtIHVzaW5nIGxpYmMgDQoyLjMuMyBhbmQgbGliYyAyLjMuNC48
L1NQQU4+PC9GT05UPjwvRElWPg0KPERJVj48Rk9OVCBmYWNlPUFyaWFsIHNpemU9Mj48U1BBTiAN
CmNsYXNzPTg4MDAyNDYxMC0yOTA3MjAwNT48L1NQQU4+PC9GT05UPiZuYnNwOzwvRElWPg0KPERJ
Vj48Rk9OVCBmYWNlPUFyaWFsIHNpemU9Mj48U1BBTiANCmNsYXNzPTg4MDAyNDYxMC0yOTA3MjAw
NT5Ob3RlOjwvU1BBTj48L0ZPTlQ+PC9ESVY+DQo8RElWPjxGT05UIGZhY2U9QXJpYWwgc2l6ZT0y
PjxTUEFOIGNsYXNzPTg4MDAyNDYxMC0yOTA3MjAwNT5vbiAyLjMuMiwgbm8gDQoiU2VnbWVudCBG
YXVsdCIsIGl0IGxvb2tzIGdvb2QuPC9TUEFOPjwvRk9OVD48L0RJVj4NCjxESVY+PEZPTlQgZmFj
ZT1BcmlhbCBzaXplPTI+PFNQQU4gDQpjbGFzcz04ODAwMjQ2MTAtMjkwNzIwMDU+PC9TUEFOPjwv
Rk9OVD4mbmJzcDs8L0RJVj4NCjxESVY+PEZPTlQgZmFjZT1BcmlhbCBzaXplPTI+PFNQQU4gY2xh
c3M9ODgwMDI0NjEwLTI5MDcyMDA1PkhhcyZuYnNwO2FueW9uZSBoYWQgDQphIHRlc3Qgb2YgTlBU
TCBvbiBVTUw/PC9TUEFOPjwvRk9OVD48L0RJVj4NCjxESVY+PEZPTlQgZmFjZT1BcmlhbCBzaXpl
PTI+PFNQQU4gDQpjbGFzcz04ODAwMjQ2MTAtMjkwNzIwMDU+PC9TUEFOPjwvRk9OVD4mbmJzcDs8
L0RJVj4NCjxESVY+PEZPTlQgZmFjZT1BcmlhbCBzaXplPTI+PFNQQU4gDQpjbGFzcz04ODAwMjQ2
MTAtMjkwNzIwMDU+PC9TUEFOPjwvRk9OVD4mbmJzcDs8L0RJVj4NCjxESVY+PEZPTlQgZmFjZT1B
cmlhbCBzaXplPTI+PFNQQU4gDQpjbGFzcz04ODAwMjQ2MTAtMjkwNzIwMDU+VGhhbmtzLDwvU1BB
Tj48L0ZPTlQ+PC9ESVY+DQo8RElWPjxGT05UIGZhY2U9QXJpYWwgc2l6ZT0yPjxTUEFOIA0KY2xh
c3M9ODgwMDI0NjEwLTI5MDcyMDA1PlRvbTwvU1BBTj48L0ZPTlQ+PC9ESVY+DQo8RElWPjxGT05U
IGZhY2U9QXJpYWwgc2l6ZT0yPjxTUEFOIA0KY2xhc3M9ODgwMDI0NjEwLTI5MDcyMDA1PjwvU1BB
Tj48L0ZPTlQ+Jm5ic3A7PC9ESVY+DQo8RElWPjxGT05UIGZhY2U9QXJpYWwgc2l6ZT0yPjxTUEFO
IA0KY2xhc3M9ODgwMDI0NjEwLTI5MDcyMDA1PjwvU1BBTj48L0ZPTlQ+Jm5ic3A7PC9ESVY+DQo8
RElWPjxGT05UIGZhY2U9QXJpYWwgc2l6ZT0yPjxTUEFOIA0KY2xhc3M9ODgwMDI0NjEwLTI5MDcy
MDA1PjwvU1BBTj48L0ZPTlQ+Jm5ic3A7PC9ESVY+DQo8RElWPjxGT05UIGZhY2U9QXJpYWwgc2l6
ZT0yPjxTUEFOIA0KY2xhc3M9ODgwMDI0NjEwLTI5MDcyMDA1PjwvU1BBTj48L0ZPTlQ+Jm5ic3A7
PC9ESVY+PC9CT0RZPjwvSFRNTD4NCg==

------_=_NextPart_001_01C5942E.71C095AD--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

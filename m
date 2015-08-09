Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1ZOUr6-0004KT-H7
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Aug 2015 17:57:56 +0000
Received: from mail-oi0-f43.google.com ([209.85.218.43])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZOUr5-0005pg-Ei
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Aug 2015 17:57:56 +0000
Received: by oio137 with SMTP id 137so75219102oio.0
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 09 Aug 2015 10:57:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1436968695.3096.12.camel@m3y3r.de>
References: <1436794918.3306.5.camel@m3y3r.de>
	<CAFLxGvwo2hjvrkF_ChR1Ooc6o7OqEGEOKnP=4NAmt8vP07Kd-Q@mail.gmail.com>
	<1436795884.3306.7.camel@m3y3r.de> <55A3C47B.8040206@nod.at>
	<1436797445.3306.10.camel@m3y3r.de> <55A3CE2F.5030105@nod.at>
	<1436800131.3096.1.camel@m3y3r.de> <55A3D510.7000508@nod.at>
	<1436800335.3096.2.camel@m3y3r.de>
	<CAFLxGvwtR+obJ97Zjh81JMjMgsY4+hhX4qupbhOem7CaGpjGSQ@mail.gmail.com>
	<1436968695.3096.12.camel@m3y3r.de>
Date: Sun, 9 Aug 2015 19:57:49 +0200
Message-ID: <CAFLxGvyaL0WrSmfqrdQ8uV576tg_Jo=hupeEo1x+EF_-sYdF3g@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Content-Type: multipart/mixed; boundary=001a113d67b2764f27051ce49b7e
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] uml_net zombie processes
To: Thomas Meyer <thomas@m3y3r.de>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

--001a113d67b2764f27051ce49b7e
Content-Type: text/plain; charset=UTF-8

On Wed, Jul 15, 2015 at 3:58 PM, Thomas Meyer <thomas@m3y3r.de> wrote:
> Am Mittwoch, den 15.07.2015, 12:12 +0200 schrieb Richard Weinberger:
>> On Mon, Jul 13, 2015 at 5:12 PM, Thomas Meyer <thomas@m3y3r.de>
>> wrote:
>> > Am Montag, den 13.07.2015, 17:11 +0200 schrieb Richard Weinberger:
>> > > Am 13.07.2015 um 17:08 schrieb Thomas Meyer:
>> > > > Am Montag, den 13.07.2015, 16:41 +0200 schrieb Richard
>> > > > Weinberger:
>> > > > > Am 13.07.2015 um 16:24 schrieb Thomas Meyer:
>> > > > > > > Yeah. And please add a dump_stack() to figure out where
>> > > > > > > it
>> > > > > > > was
>> > > > > > > called.
>> > > > > >
>> > > > > > I think calling dump_stack() somehow changed the errno to
>> > > > > > 25?!
>> > > > >
>> > > > > >
>> > > > > > +extern __attribute__((regparm(0))) void dump_stack(void);
>> > > > >
>> > > > > Hmm, maybe the regparm(0) kills your stack.
>> > > > > Anyway, how do you trigger the issue?
>> > > > > I tried here and don't see any zombie processes?
>> > > > > In my setup I run UML as non-root and tap0 is owned by root.
>> > > > > -> UML is unable to setup eth0.
>> > > > > But no zombies here.
>> > > >
>> > > > I run UML as non-root user, tun is:
>> > > >
>> > > > $ ll /dev/net
>> > > > insgesamt 0
>> > > > crw-rw----. 1 root zml-net 10, 200 13. Jul 14:49 tun
>> > > >
>> > > > $ ll /usr/bin/uml_net
>> > > > -rwsr-x---. 1 root uml-net 31472 19. Aug 2014  /usr/bin/uml_net
>> > >
>> > > And eth0=tuntap,tap?
>> >
>> > yes,
>> >
>> > eth0=tuntap,,,192.168.10.2
>>
>> Sorry for the late reply.
> Hi,
>
> null problemo.
>
>> I'm still burred in work issues and had no time to look in detail at
>> this.
>>
>> But in the meanwhile you can try to gather some more Infos.
>> Remove the dump_stack() and add some printk()s.
>> I'm interested which PIDs are returned and waited for.
>
> Mhh.. I think the pid is already printed in error case:
>
> [   15.930000] helper_wait : waitpid process 11673 failed, errno = 10
> [   15.930000] * modprobe tun
>                * ifconfig tap0 192.168.10.1 netmask 255.255.255.255 up
>                * bash -c echo 1 > /proc/sys/net/ipv4/ip_forward
> [   20.480000] helper_wait : waitpid process 11780 failed, errno = 10
> [   20.480000] * route add -host 192.168.10.2 dev tap0
>                * bash -c echo 1 > /proc/sys/net/ipv4/conf/tap0/proxy_arp
>
> pid 11673 and pid 11780 in above case were the two zombie processes.
>
> errno 10 = ECHILD
>
> which can happen for the waitpid() call, according to the man page:
>
>        ECHILD (for  waitpid()  or waitid()) The process specified by pid (waitpid()) or idtype and id (waitid()) does not exist or
>               is not a child of the calling process.  (This can happen for one's own child if the action for  SIGCHLD  is  set  to
>               SIG_IGN.  See also the Linux Notes section about threads.)
>
> I'm not able to completely figure out above meaning, so...
> But maybe ECHILD is returned because uml_net is run with setuid bit
> set?
>
> any ideas?

The attached fix should fix the issue. Please confirm.

-- 
Thanks,
//richard

--001a113d67b2764f27051ce49b7e
Content-Type: text/plain; charset=US-ASCII; name="uml_waitpid.diff"
Content-Disposition: attachment; filename="uml_waitpid.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_id4sma000

ZGlmZiAtLWdpdCBhL2FyY2gvdW0vb3MtTGludXgvaGVscGVyLmMgYi9hcmNoL3VtL29zLUxpbnV4
L2hlbHBlci5jCmluZGV4IGUzZWU0YTUuLjNmMDJkNDIgMTAwNjQ0Ci0tLSBhL2FyY2gvdW0vb3Mt
TGludXgvaGVscGVyLmMKKysrIGIvYXJjaC91bS9vcy1MaW51eC9oZWxwZXIuYwpAQCAtOTYsNyAr
OTYsNyBAQCBpbnQgcnVuX2hlbHBlcih2b2lkICgqcHJlX2V4ZWMpKHZvaWQgKiksIHZvaWQgKnBy
ZV9kYXRhLCBjaGFyICoqYXJndikKIAkJCSAgICAgICAicmV0ID0gJWRcbiIsIC1uKTsKIAkJCXJl
dCA9IG47CiAJCX0KLQkJQ0FUQ0hfRUlOVFIod2FpdHBpZChwaWQsIE5VTEwsIF9fV0NMT05FKSk7
CisJCUNBVENIX0VJTlRSKHdhaXRwaWQocGlkLCBOVUxMLCBfX1dBTEwpKTsKIAl9CiAKIG91dF9m
cmVlMjoKQEAgLTEyOSw3ICsxMjksNyBAQCBpbnQgcnVuX2hlbHBlcl90aHJlYWQoaW50ICgqcHJv
Yykodm9pZCAqKSwgdm9pZCAqYXJnLCB1bnNpZ25lZCBpbnQgZmxhZ3MsCiAJCXJldHVybiBlcnI7
CiAJfQogCWlmIChzdGFja19vdXQgPT0gTlVMTCkgewotCQlDQVRDSF9FSU5UUihwaWQgPSB3YWl0
cGlkKHBpZCwgJnN0YXR1cywgX19XQ0xPTkUpKTsKKwkJQ0FUQ0hfRUlOVFIocGlkID0gd2FpdHBp
ZChwaWQsICZzdGF0dXMsIF9fV0FMTCkpOwogCQlpZiAocGlkIDwgMCkgewogCQkJZXJyID0gLWVy
cm5vOwogCQkJcHJpbnRrKFVNX0tFUk5fRVJSICJydW5faGVscGVyX3RocmVhZCAtIHdhaXQgZmFp
bGVkLCAiCkBAIC0xNDgsNyArMTQ4LDcgQEAgaW50IHJ1bl9oZWxwZXJfdGhyZWFkKGludCAoKnBy
b2MpKHZvaWQgKiksIHZvaWQgKmFyZywgdW5zaWduZWQgaW50IGZsYWdzLAogaW50IGhlbHBlcl93
YWl0KGludCBwaWQpCiB7CiAJaW50IHJldCwgc3RhdHVzOwotCWludCB3ZmxhZ3MgPSBfX1dDTE9O
RTsKKwlpbnQgd2ZsYWdzID0gX19XQUxMOwogCiAJQ0FUQ0hfRUlOVFIocmV0ID0gd2FpdHBpZChw
aWQsICZzdGF0dXMsIHdmbGFncykpOwogCWlmIChyZXQgPCAwKSB7Cg==
--001a113d67b2764f27051ce49b7e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--001a113d67b2764f27051ce49b7e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--001a113d67b2764f27051ce49b7e--



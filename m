Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1APXDZ-0006ft-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 27 Nov 2003 17:14:45 -0800
Received: from pop.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1APXDY-0002gK-GI
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 27 Nov 2003 17:14:44 -0800
Message-ID: <010c01c3b54d$99552830$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <Pine.LNX.4.44.0311280047120.28924-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: [uml-devel] bug in COW? -  Re: [uml-user] uml 2.6.0-test9 crash
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 28 Nov 2003 02:18:57 +0100
Content-Transfer-Encoding: quoted-printable
To: Henrik Nordstrom <hno@marasystems.com>, Sven 'Darkman' Michels <sven@darkman.de>
Cc: user-mode-linux-devel@lists.sourceforge.net, uml-user <user-mode-linux-user@lists.sourceforge.net>

Hi!
I made some further investigation.
i forgot to mention, that i`m using reiserfs and also use the copy-on-write=
(cow)
feature, uml has. the system-freeze i experience seems to have to do with c=
opy-on-write.
as a test, i made a copy of my rootfs, made it available under /dev/ubd/2 i=
nside the
uml and mounted that under /mnt. i did an extra fsck before - no inconsiste=
ncy was
reported. then i did some stresstests again - worked fine!

after making the rootfs-clone a cow-filesystem (by adding ubd2=3Drootfsclon=
e.cow,rootfsclone.img),
the freeze happened again when doing some heavy writing. so - am i allowed =
to assume, that
there is a bug in the copy-on-write code?
btw: could anybody recommend a general filesystem stresstest-tool which doe=
s the worst to
filesytems, you can do (besides formatting or overwriting)? :D
it seems, that this bug happens under certain circumstances only.  if i "dd=
" to an empty filesystem,
it doesn`t seem to freeze the uml at once. but it happend again after a whi=
le, when i did some
additionial copying of directory-trees while dd`=ECng to disk in the backgr=
ound.

regards
roland

ps:
accidentally, i opened a cow-file with vi - and i saw that the path to the =
original readonly
filesystem image seems to be stored with full path information. would that =
mean: if i want to
relocate the fs-image with it`s accociated cow-file, i`m out of luck? is th=
ere any reason why
there are absolute, not relative paths inside?

pps:
> > The UML did the frist two dd's without problems, then it started to
> > hang.. i checked outside and saw the process switching states from
> > R to D and then back to R... so after a few secs the dd's did all
> > succeed and the uml is still running. So it didn't crash or so
> > but it also didn't play very well with that.
>
> Sounds as if it started to get blocked by disk I/O on the host.. ubd
> device I/O is a latency killer for UML as a blocking disk I/O operation
> will block the whole UML kernel until the host finishes.
yes - i think what hendrik says is right! this is just normal behaviour. th=
e first 2 dd`s
ran without "problems" because the host just cached that i/o`s. then it beg=
an writing to disk
and this may have caused some delay you recognized as a "hang". in general =
- i/o scheduling of 2.4.x
kernels is not the very best. 2.6 kernel series has new i/o schedulers whic=
h are improved a LOT!




----- Original Message -----=20
From: "Henrik Nordstrom" <hno@marasystems.com>
To: "Sven 'Darkman' Michels" <sven@darkman.de>
Cc: <user-mode-linux-devel@lists.sourceforge.net>
Sent: Friday, November 28, 2003 12:50 AM
Subject: Re: [uml-devel] Re: [uml-user] uml 2.6.0-test9 crash


> On Thu, 27 Nov 2003, Sven 'Darkman' Michels wrote:
>
> > The UML did the frist two dd's without problems, then it started to
> > hang.. i checked outside and saw the process switching states from
> > R to D and then back to R... so after a few secs the dd's did all
> > succeed and the uml is still running. So it didn't crash or so
> > but it also didn't play very well with that.
>
> Sounds as if it started to get blocked by disk I/O on the host.. ubd
> device I/O is a latency killer for UML as a blocking disk I/O operation
> will block the whole UML kernel until the host finishes.
>
> > BTW: did you had any problems with building an uml kernel on 9.0?
>
> I have no problem with building UML on RH9, but I have a memory of some
> singnal trick which was needed at some point.. Make sure the UML is up to
> date.
>
> Regards
> Henrik
>


hi !=B4
i think , i`m able to crash my uml. :(

i did some stress-testing with my uml-2.6.0-test9 on 2.6.0-test9-skas host =
and i
unfortunately seem able to crash it very easily.

this was the way i recognized it:
first i executed
while true;do find /;done >/dev/zero &
several times and all worked well.
watched that with "top" inside the uml and found dozens of "finds" sharing =
the
cpu as expected(spending most of their time on system calls indeed).
on host, cpu usage of uml went to ~99% - all fine so far.

then i thought: mhhhh - ok - eat THIS:
while true;do dd if=3D/dev/zero of=3Dtest.dat bs=3D1k count=3D10000;done &

after executing this, my uml got stuck. no output, no response to input - e=
ven a
ping to the uml didn`t=B4give back a sign of life. the uml didn`t crash or =
panic - it
just gets stuck and unresponsive - uml process remains at 99% on the host.

at a second, third, fourth try, i isolated the problem a little bit:
one or two non looped "dd if=3D/dev/zero of=3Dtest.dat bs=3D1k count=3D1000=
0" just are enough
to produce the same result.(under 2.6.0test9-skas-host and ALSO under 2.4.2=
2-99-default
suse9 host, rootfs inside uml is suse9)

is anybody able to reproduce this?
if so - what do do further for analyzing?
i could make the uml downloadable and could send some output from strace (i=
f i attach strace
to the remaining "99% cpu hog", it exits very quickly with a SIGALARM)

maybe an uml bug or even an issue for lkml?

regards
roland



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

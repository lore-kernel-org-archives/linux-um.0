Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQsAn-0003WD-BL for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 20 May 2004 11:21:41 -0700
Received: from imap.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BQsAm-0006o7-NO for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 20 May 2004 11:21:40 -0700
Message-ID: <01fa01c43e98$4420d510$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <20040229043549.GA8583@ccure.user-mode-linux.org>
	<02dc01c43c4a$bb7c0490$2000000a@schlepptopp>
	<1084831251.1230.4.camel@chartreuse>
	<03ff01c43c5d$7db6e5e0$2000000a@schlepptopp>
	<20040518175904.GB29114@ccure.user-mode-linux.org>
	<1084987654.2250.4.camel@chartreuse>
Subject: Re: [uml-devel] [PATCH] host context switch reduction
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
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
Date: Thu, 20 May 2004 20:28:36 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

hi,
i had a conversation with laurent regarding dynamic toggling of the new sys=
emu feature via procfs.

>I think switching on/off sysemu is only needed if sysemu doesn't work
>correctly and in a debug context.
>
>You must know that I don't want to make "cosmetic" work on sysemu
>(except correcting the strace problem) because : I don't use UML (I make
>this patch in a prospecting work), all my systems are powerpc based,
>and he acknoweledged, that it would be ok,
....
>> if not, via kernel-commandline-param, maybe this is even possible dynami=
cally, from
inside uml ?
>
>yes, from a /proc/sys toggle to set the internal "use_sysemu" variable to =
0.

i think this would be useful to do better performance comparison and for de=
termining the
"real world" benefit of this patch (it`s like applying and releasing the br=
ake)

 echo 1 >/proc/sysemu    - now sysemu is ON
 benchmark your application/uml
 echo 0 >/proc/sysemu    - now sysemu is OFF
 benchmark your application/uml again
 compare

do you think this is useful ?

i would have already done this "cosmetic work", but for sure i need some he=
lp because
i`m no good programmer (but i would like starting some kernelhacking :)
i have read some docs how procfs programming is being done and it seems rea=
sonable simple
for me.

so i want to hear your opinion first, before getting on your nerves with (r=
eally dumb kernel-
hackernewbie) questions for a feature, nobody wants to have :)

roland





----- Original Message -----=20
From: "Laurent Vivier" <LaurentVivier@wanadoo.fr>
To: "Jeff Dike" <jdike@addtoit.com>
Cc: "roland" <for_spam@gmx.de>; <user-mode-linux-devel@lists.sourceforge.ne=
t>
Sent: Wednesday, May 19, 2004 7:27 PM
Subject: Re: [uml-devel] [PATCH] host context switch reduction


Hi,

as it is a plebiscite ;-), find attached the patch for UML 2.6.6 and
measurements I made on my poor netserver.

Laurent

Le mar 18/05/2004 =E0 19:59, Jeff Dike a =E9crit :
> On Tue, May 18, 2004 at 12:22:45AM +0200, roland wrote:
> > the question is:
> > is the "real world" performance benefit, uml get`s from this patch wort=
h taking your time and is it implemented in a way, so
that
> > uml maintainers are happy with that ?
>
> The patch seems reasonable to me.  I'd be happiest with Laurent pushing t=
his
> into mainline himself.
>
> > i cannot really estimate, what performance benefits your patch brings t=
o uml in detail, but what i have seen so far, this seems
> > quite worth doing the work.  reducing context switches by 1/3 is a LOT,=
 imho - and reducing the execution time of the
getpid-loop to
> > nearly the half is quite impressive.
>
> Yeah, but no real workloads do while(1) getpid();
>
> The kernel build improvement is obviously smaller, but still worth having.
>
> > are there any "con`s" that argue for that work _NOT_ being done ?
>
> No.  But testing, and happy reports to the appropriate mailing lists would
> help.
>
> Jeff



---------------------------------------------------------------------------=
-----


> HP Netserver LH Pro bi-pro 200 MHz / 256 MB RAM
>
> NATIF:
>
> netserver:/usr/src# uname -a
> Linux netserver 2.4.24-sysemu #4 SMP Tue Feb 17 16:43:11 CET 2004 i686 GN=
U/Linux
>
> netserver:/usr/src# time ./getpid 1000000
>
> real    0m1.763s
> user    0m0.910s
> sys     0m0.860s
>
> real    0m1.759s
> user    0m0.900s
> sys     0m0.870s
>
> real    0m1.759s
> user    0m0.950s
> sys     0m0.800s
>
> UML with sysemu:
>
> (none):~# uname -a
> Linux (none) 2.6.6-1um #10 Wed May 19 12:54:37 CEST 2004 i686 unknown
>
> (none):/mnt/usr/src# time ./getpid 1000000
>
> real    1m1.508s
> user    0m7.960s
> sys     0m53.450s
>
> real    1m1.881s
> user    0m6.630s
> sys     0m55.240s
>
> real    1m1.920s
> user    0m6.580s
> sys     0m55.340s
>
> UML w/o sysemu
>
> real    1m32.833s
> user    0m7.610s
> sys     1m25.130s
>
> real    1m32.921s
> user    0m7.890s
> sys     1m24.980s
>
> real    1m33.493s
> user    0m8.010s
> sys     1m24.960s
>



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g.=20
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3D3149&alloc_id=3D8166&op=3Dclick
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

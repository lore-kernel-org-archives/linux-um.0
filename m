Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQVGU-0007id-NP for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 May 2004 10:54:02 -0700
Received: from mail.gmx.net ([213.165.64.20])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BQVGU-0006Pt-1s for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 May 2004 10:54:02 -0700
Message-ID: <012201c43dcb$402ca6a0$2000000a@schlepptopp>
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
Date: Wed, 19 May 2004 20:01:02 +0200
Content-Transfer-Encoding: quoted-printable
To: Laurent Vivier <LaurentVivier@wanadoo.fr>, Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Hi Laurent !
Great!
Thanks a lot for your work :)

but i have a question:

old mail from jeff:
>The patches below are from Laurent Vivier who didn't make them public.  Th=
ey
>add a new feature to ptrace on the host which cuts down on the number of
>context switches needed for a UML system call, plus makes UML use it

so - if your patch adds a new feature for ptrace on the HOST - shouldn`t we=
 need TWO patches for 2.6 ?
One patch for uml and one patch for the host ?

this one seems for uml only.
some of us already run uml 2.6(.x) on a 2.6.(.x) host and put their focus o=
n the "new kernel" (me too).

regards
roland

ps:
since this would be the 2nd patch for the HOST (besides skas), would it mak=
e sense, to merge "skas" and "sysemu" into one common
HOST-patch (if it has been tested and approved stable) ?



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
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=3D2562&alloc_id=3D6184&op=3Dclick
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

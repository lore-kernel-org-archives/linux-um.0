Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zfer-0003CR-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Wed, 17 Sep 2003 10:00:01 -0700
Received: from stclair.eecs.umich.edu ([141.213.8.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 19zfeq-00014P-Fb
	for User-mode-linux-devel@lists.sourceforge.net; Wed, 17 Sep 2003 10:00:00 -0700
From: George Washington Dunlap III <dunlapg@umich.edu>
Subject: Re: [uml-devel] UML and Execution Replay
In-Reply-To: <200309170745.h8H7jVQ11917@mailgate5.cinetic.de>
Message-ID: <Pine.LNX.4.44.0309171248230.19821-100000@stclair.eecs.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
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
Date: Wed, 17 Sep 2003 12:59:59 -0400 (EDT)
Content-Transfer-Encoding: quoted-printable
To: Oliver Oppitz <o.oppitz@web.de>
Cc: "Patrick \"Petschge\" Kilian" <petschge@web.de>, User-mode-linux-devel@lists.sourceforge.net

On Wed, 17 Sep 2003, Oliver Oppitz wrote:

> Yes, indeed that is the more tricky part. However, there are known
> techniques for handling this. One involves a hardware instruction
> counter. Using this you can record exactly in what moment some input
> (e.g. an interrupt) was received. Hardware instruction counters in
> current CPUs are however pretty imprecise, in particular in x86.
> Motorola PowerPC 7410 is pretty precise.

There are other counts you can use instead, however.  For instance, <eip,
branch count> tuples, or <memory writes, [register state]>.  The
instruction counters on P4s and AMDs are imprecise, but the P4 counter
named "retired_branch_type" is very accurate.  On the AMDs, they have a
branch counter which is accurate as well, but unfortunately also counts=20
hardware interrupts and software exceptions: including page faults and=20
math coprocessor exceptions (for lazy FPU sharing).  You just have to=20
instrument the host kernel to count these and subtract them off, and=20
you're golden.

We've been using these counters on the AMD for over a year, and the P4 for =

several months, all with extensive testing, and had no problems replaying.

> An alternative technique is called "unique marker". When there is an
> interrupt you record some checksums over the register file, parts of the
> stack etc. For the replay you insert breakpoint instructions at all
> places where an interrupt had occured in the execution phase. By
> comparing the stored checksum with the current register file/stack you
> can determine "where" in the program flow you are. Obviously there is
> potential for ambiguity but not much. It works in practice. Henrik Thane
> at the MRTC (M=E4lardalen Real Time Research Center,
> http://www.mrtc.mdh.se/) works on this.

This sounds like an interesting idea.  Our focus is security, however,=20
so there are two problems with that idea.  First, though accidental=20
ambiguity may be unlikely, an attacker can craft state that will be=20
ambiguous and thwart your replaying system. =20

Secondly, if you get an interrupt on the millionth iteration of an
extermely tight loop, you have to set the breakpoint one million times,
which is incredibly slow.  (UMLinux measuring the BogoMIPS, for instance,
took less than a second to log, and an hour to replay.)  With the
performance counters, the P4 and AMD have a feature where you can set the
counters to a negative number and get an interrupt when it overflows. =20
This isn't 100% precise (because of deep pipelines, etc) but it will get
you within about 100 branches, and you can breakpoint from there.

Are there any similar optimizations for the unique marker approach?

> Because I want to work on x86 I favour the latter approach.=20

The former can be made to work on x86, we've done it quite robustly. =3D)  =

E-mail me if you want some help.

 -George

--=20
+-------------------+----------------------------------------
| dunlapg@umich.edu | http://www-personal.umich.edu/~dunlapg=20
+-------------------+----------------------------------------
| ...there be many, many ancient systems in the world, and it=20
| is the decree of the dreaded god Murphy that thy next=20
| employment just might be on one.  While thou sleepest, he=20
| plotteth against thee.  Awake and take care.
|   - Henry Spencer, "The Ten Commandments for C Programmers"
+------------------------------------------------------------
| Outlaw Junk Email! Support HR 1748 (www.cauce.org)



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zX0l-0000rM-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Wed, 17 Sep 2003 00:46:03 -0700
Received: from mailgate5.cinetic.de ([217.72.192.165])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19zX0k-0004nz-BI
	for User-mode-linux-devel@lists.sourceforge.net; Wed, 17 Sep 2003 00:46:02 -0700
Message-Id: <200309170745.h8H7jVQ11917@mailgate5.cinetic.de>
MIME-Version: 1.0
From: "Oliver Oppitz" <o.oppitz@web.de>
Subject: Re: [uml-devel] UML and Execution Replay
Content-Type: text/plain; charset="iso-8859-1"
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
Date: Wed, 17 Sep 2003 09:45:31 +0200
Content-Transfer-Encoding: quoted-printable
To: "Patrick \"Petschge\" Kilian" <petschge@web.de>, User-mode-linux-devel@lists.sourceforge.net

"Patrick \"Petschge\" Kilian" <petschge@web.de>=20
> The only problem is, that you have to replay the input with the exact=20
> correct timing.

Yes, indeed that is the more tricky part. However, there are known techniqu=
es for handling this. One involves a hardware instruction counter. Using th=
is you can record exactly in what moment some input (e.g. an interrupt) was=
 received. Hardware instruction counters in current CPUs are however pretty=
 imprecise, in particular in x86. Motorola PowerPC 7410 is pretty precise.

An alternative technique is called "unique marker". When there is an interr=
upt you record some checksums over the register file, parts of the stack et=
c. For the replay you insert breakpoint instructions at all places where an=
 interrupt had occured in the execution phase. By comparing the stored chec=
ksum with the current register file/stack you can determine "where" in the =
program flow you are. Obviously there is potential for ambiguity but not mu=
ch. It works in practice. Henrik Thane at the MRTC (M=E4lardalen Real Time =
Research Center, http://www.mrtc.mdh.se/) works on this.=20

Because I want to work on x86 I favour the latter approach.=20

Regards, Oliver

___________________________________________________________________________=
___
Es geht nicht  mehr ohne Handy, aber geht es auch guenstiger?
Ja, mit Call by Call vom Handy. http://handybycall.web.de/?mc=3D021103



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

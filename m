Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AMtyz-0004Q7-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 20 Nov 2003 10:56:49 -0800
Received: from spoetnik.kulnet.kuleuven.ac.be ([134.58.240.46])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AMtyz-0006ff-4x
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 20 Nov 2003 10:56:49 -0800
From: Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>
Subject: Re: [uml-devel] Host panic triggered by UML
References: <200311201915.29188.blaisorblade_spam@yahoo.it>
In-Reply-To: <200311201915.29188.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200311201956.39623.Frank.dekervel@student.kuleuven.ac.Be>
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
Date: Thu, 20 Nov 2003 19:56:39 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>

Op Thursday 20 November 2003 19:15, schreef BlaisorBlade:
> I reported that if I leave an UML sleeping, it segfaults(once I saw the
> killed by SIGSEGV from the shell, the other time nothing, maybe I had
> detached the job from the shell).
>
> Now I've seen that what happens is that the host kernel oopses. I'm posting
> it here to collect a bit more infos before posting it to the LKML, and to
> know why only UML is able to trigger it. Since the bug seems related only
> to /dev/shm, maybe you could have some enlightenment about it and how UML
> uses shared memory to make this happen.

i saw the same crash. i worked around it by not using hostfs ...

greetings,
frank


-- 
Frank Dekervel
Mechelsestraat 88
3000 Leuven
frank.dekervel@student.kuleuven.ac.be, (nieuw) 0473/94.34.21


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

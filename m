Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DfgXX-0003yk-KA	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Jun 2005 09:02:55 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user51242)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DfgXV-0001Ax-I9	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Jun 2005 09:02:55 -0700
Subject: Re: [uml-devel] [Bug 49277] Compile of usermode-sources-2.6.x fails
References: <E1DfSPm-0008Vv-Va@nuthatch.gentoo.org>
	<87psuy5jcj.fsf@amaterasu.srvr.nix>
	<200506071732.07844.blaisorblade@yahoo.it>
From: Nix <nix@esperi.org.uk>
In-Reply-To: <200506071732.07844.blaisorblade@yahoo.it>
	(blaisorblade@yahoo.it's message of "Tue, 7 Jun 2005 16:52:37 +0200")
Message-ID: <87ekbe5f4m.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Tue, 07 Jun 2005 17:02:49 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, bugzilla-daemon@gentoo.org

On Tue, 7 Jun 2005, blaisorblade@yahoo.it said:
> Just give me the time to actually upload the tree, which I'm doing at the 
> moment, and forgive me if I added anything ruining the compilation while I 
> was working on x86_64 host.

Patch mis-rolled, I guess: arch/um/scripts/Makefile.rules is missing,
yet included from multiple places:

  CHK     usr/initramfs_list
arch/um/kernel/Makefile:34: arch/um/scripts/Makefile.rules: No such file or directory
make[1]: *** No rule to make target `arch/um/scripts/Makefile.rules'.  Stop.
make: *** [arch/um/kernel] Error 2

(I could grab the copy from -bs5, but I don't know if it's changed since
then, or even if it's still meant to be there at all. I could check the
-broken-out, but I have no guarantee that that isn't equally confused :) )

-- 
`It's as bizarre an intrusion as, I don't know, the hobbits coming home
 to find that the Shire has been taken over by gangsta rappers.'


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BdAOs-0005bO-EZ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Jun 2004 09:15:02 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user26838)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BdAOr-00067u-Pp for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Jun 2004 09:15:02 -0700
Subject: Re: [uml-devel] [patch 1/1] Avoid that gcc breaks UML with "unit at
	a time" compilation mode.
References: <200406191247.19316.blaisorblade_work@yahoo.it>
From: Nix <nix@esperi.org.uk>
In-Reply-To: <200406191247.19316.blaisorblade_work@yahoo.it> (BlaisorBlade's
	message of "Sat, 19 Jun 2004 12:47:48 +0200")
Message-ID: <87k6xynte1.fsf@amaterasu.srvr.nix>
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
Date: Wed, 23 Jun 2004 17:14:46 +0100
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

On Sat, 19 Jun 2004, BlaisorBlade mused:
> Avoid that gcc breaks UML with "unit at a time" compilation mode; this patch 
> is for 2.6. Please test it.

btw, I'd call this a workaround. Only a very few files --- that depend on
the exact ordering of functions, variable declarations, or top-level asm
blocks in the file --- should need it.

Eventually, non-unit-at-a-time mode will probably go away entirely.

-- 
`We in no way believe that this Christ was a space alien.'
                    --- A creationist website goes completely bonkers


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bfp5G-0002No-Hi for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Jun 2004 17:05:46 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1Bfp5G-00032v-2M
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Jun 2004 17:05:46 -0700
Message-Id: <200407010100.i61108Yp007078@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Humfs directory creation bug. 
In-Reply-To: Your message of "Mon, 07 Jun 2004 18:44:27 +0200."
	<200406071844.27297.sikkh@wp.pl> 
References: <200406071844.27297.sikkh@wp.pl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Wed, 30 Jun 2004 21:00:08 -0400
To: Piotr Neuman <sikkh@wp.pl>
Cc: user-mode-linux-devel@lists.sourceforge.net

sikkh@wp.pl said:
> Humfs code misreported device when getting stat info on directories.
> This code  hopefully fixes that (mv will work with hardlinks as
> expected now). 
> Apply to 2.4.26-1 UML release (in arch/um/fs/hostfs/). Patch: 

Nice spotting.

However, you missed a kfree(file) along an error path.

				Jeff



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CHINy-0001s1-AE for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Oct 2004 01:51:58 -0700
Received: from scrub.xs4all.nl ([194.109.195.176] ident=mail)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CHIMk-0007VC-I5 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Oct 2004 01:51:58 -0700
From: Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <20041012001801.7FD428697@zion.localdomain>
Message-ID: <Pine.LNX.4.61.0410121048480.7182@scrub.home>
References: <20041012001801.7FD428697@zion.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Re: [patch 08/10] uml: mark broken configs
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
Date: Tue, 12 Oct 2004 10:50:07 +0200 (CEST)
To: blaisorblade_spam@yahoo.it
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Hi,

On Tue, 12 Oct 2004 blaisorblade_spam@yahoo.it wrote:

> -menu "SCSI support"
> +if BROKEN
> +	menu "SCSI support"

You can add "depends on BROKEN" after the menu statement with the same 
effect.

bye, Roman


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

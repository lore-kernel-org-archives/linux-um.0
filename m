Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BqhA2-0007oH-UX for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Jul 2004 16:51:38 -0700
Received: from pop.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1BqhA2-0000Pg-BY for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Jul 2004 16:51:38 -0700
From: Daniel Heemann <daniel.heemann@gmx.de>
Reply-To: daniel.heemann@gmx.de
Subject: Re: [uml-devel] Re: Bug#260111: user-mode-linux: upgrade hangs at
	"NET4: Linux TCP/IP 1.0 for NET4.0 "
References: <200407280315.08207.alydar@users.sourceforge.net>
	<200407292234.04279.alydar@users.sourceforge.net>
	<200407301723.i6UHNeUE002844@ccure.user-mode-linux.org>
In-Reply-To: <200407301723.i6UHNeUE002844@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407310151.49188.daniel.heemann@gmx.de>
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
Date: Sat, 31 Jul 2004 01:51:48 +0200
To: user-mode-linux-devel@lists.sourceforge.net

On Friday 30 July 2004 19:23, Jeff Dike wrote:
> The move_console_write patch at
> http://user-mode-linux.sourceforge.net/patches.html backs out this part
> of that change.
>
> Can anyone who's seeing this check that it fixes the hang?
>
> 				Jeff

Fixes the hang here, too.

Regards
Daniel

-- 
"Those who would give up essential liberty, to purchase a little temporary 
safety, deserve neither liberty nor safety."  - Benjamin Franklin


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

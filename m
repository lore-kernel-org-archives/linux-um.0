Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BqbPX-00010t-LA for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Jul 2004 10:43:15 -0700
Received: from w218.z064002068.nyc-ny.dsl.cnc.net ([64.2.68.218])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1BqbPX-0004wJ-1O for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Jul 2004 10:43:15 -0700
From: Allen Chan <alydar@users.sourceforge.net>
References: <200407280315.08207.alydar@users.sourceforge.net>
	<200407301723.i6UHNeUE002844@ccure.user-mode-linux.org>
	<410A833F.9030207@hevanet.com>
In-Reply-To: <410A833F.9030207@hevanet.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407301343.11200.alydar@users.sourceforge.net>
Subject: [uml-devel] Re: Bug#260111: user-mode-linux: upgrade hangs at "NET4:
	Linux TCP/IP 1.0 for NET4.0 "
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
Date: Fri, 30 Jul 2004 13:43:05 -0400
To: Jeff Dike <jdike@addtoit.com>
Cc: 260111@bugs.debian.org, Matt Clay <mattclay@hevanet.com>, user-mode-linux-devel@lists.sourceforge.net

Works for me.  Thanks.

On Friday 30 July 2004 01:19 pm, Matt Clay wrote:
> Jeff Dike wrote:
> > The move_console_write patch at
> > http://user-mode-linux.sourceforge.net/patches.html backs out
> > this part of that change.
> >
> > Can anyone who's seeing this check that it fixes the hang?
>
> Works for me.  What still bothers me is that turning on debugging
> symbols was "fixing" it for me as well.
>
>   - Matt


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

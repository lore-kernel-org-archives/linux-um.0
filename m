Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BrsJQ-0005vF-08 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Aug 2004 22:58:12 -0700
Message-ID: <410F2B62.7050808@hevanet.com>
From: Matt Clay <mattclay@hevanet.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: Bug#260111: user-mode-linux: upgrade hangs at
	"NET4: Linux TCP/IP 1.0 for NET4.0 "
References: <200407280315.08207.alydar@users.sourceforge.net>
	<200407281722.i6SHM6eh002963@ccure.user-mode-linux.org>
	<200407291430.18818.alydar@users.sourceforge.net>
	<200407292234.04279.alydar@users.sourceforge.net>
	<200407301723.i6UHNeUE002844@ccure.user-mode-linux.org>
	<410A833F.9030207@hevanet.com>
	<200407301849.i6UInpUE003226@ccure.user-mode-linux.org>
	<410C6367.3090206@hevanet.com>
	<20040801155231.GA19648@ccure.user-mode-linux.org>
In-Reply-To: <20040801155231.GA19648@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Mon, 02 Aug 2004 23:06:26 -0700
To: Jeff Dike <jdike@addtoit.com>
Cc: Allen Chan <alydar@users.sourceforge.net>, user-mode-linux-devel@lists.sourceforge.net, 260111@bugs.debian.org

Jeff Dike wrote:
> 
>>This patch seems to fix the problem by adding error handling to
>>the tcsetattr call in generic_console_write.
> 
> What are the errnos from the failures?

Ignore what I said before about errno not being set, I was wrong.

The answer is that tcsetattr is failing with EINTR rather frequently. 
It never seems to happen when running UML on a real console, but quite 
frequently from inside xterm, konsole or gnome-terminal.

  - Matt


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

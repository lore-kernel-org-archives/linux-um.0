Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bqomy-0004Ty-2X for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 31 Jul 2004 01:00:20 -0700
Received: from rwcrmhc12.comcast.net ([216.148.227.85])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bqomx-0008Q4-RQ for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 31 Jul 2004 01:00:20 -0700
Message-ID: <410B5158.3050004@hevanet.com>
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
In-Reply-To: <200407301849.i6UInpUE003226@ccure.user-mode-linux.org>
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
Date: Sat, 31 Jul 2004 00:59:20 -0700
To: Jeff Dike <jdike@addtoit.com>
Cc: Allen Chan <alydar@users.sourceforge.net>, user-mode-linux-devel@lists.sourceforge.net, 260111@bugs.debian.org

Jeff Dike wrote:
> 
>>Works for me.  What still bothers me is that turning on debugging
>>symbols was "fixing" it for me as well.
> 
> Yeah, this definitely needs more investigation.

Looking at the code for generic_console_write I noticed the return codes 
for tcgetattr and tcsetattr are not being checked.  After I added checks 
for the return codes, I found out that both calls to tcsetattr always 
return a non-zero status, which, according to the man pages, indicates a 
failure.  I have no idea if that is important or not.

This happens with or without the patch you supplied.

BTW: I also noticed that commenting out the second call to tcsetattr 
makes the problem go away as well.

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

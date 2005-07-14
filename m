Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dsztm-0001NS-FL	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Jul 2005 02:20:54 -0700
Received: from rimuhosting.com ([69.90.33.248])
	by sc8-sf-mx1.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1Dsztk-0006U8-0h
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Jul 2005 02:20:54 -0700
Message-ID: <42D62E66.8070709@rimuhosting.com>
From: Peter <peter.spamcatcher@rimuhosting.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: unregister_netdevice: waiting for tap24 to become
 free
References: <20050709110143.D59181E9EA4@zion.home.lan>
	<200507120020.52418.blaisorblade@yahoo.it> <42D2F22C.3060102@rimuhosting.com>
	<200507120047.33064.blaisorblade@yahoo.it>
In-Reply-To: <200507120047.33064.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
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
Date: Thu, 14 Jul 2005 21:20:38 +1200
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

I just tried 2.6.12.2 with skas-V8.2.  The server (otherwise reliable), 
had a kernel crash (which I was unable to capture) within a couple of 
hours of boot up.

Regards, Peter

Blaisorblade wrote:
> On Tuesday 12 July 2005 00:26, Peter wrote:
> 
>>Nothing in the logs prior to the first error message.
>>
>>I've hit this before at different times on other servers.  If there are
>>some commands I can run to gather more diagnostics on the problem,
>>please let me know and I'll capture more information next time.
>>
>>I see the error was reported with older 2.6 kernels and a patch was
>>floating around.  I'm not sure if that is integrated into the current
>>2.6.11 kernel.
> 
> The patch named there has been integrated, verifyable at 
> http://linux.bkbits.net:8080/linux-2.6/cset@4129735fMSVl0_RA4uNcNBWHFjT-zw
> 
> However this time the bug is probably due to something entirely different, the 
> message is not very specific.
> 
> Tried 2.6.12? SKAS has been already updated (plus there's an important update 
> for SKAS, from -V8 to -V8.2).
> 
>>http://www.google.com/search?q=unregister_netdevice%3A+waiting
>>
>>Regards, Peter
> 
> 


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

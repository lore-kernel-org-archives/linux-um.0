Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPdAO-00061i-06 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Nov 2004 00:40:24 -0800
Received: from [82.154.232.218] (helo=puma-vgertech.no-ip.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CPdAM-0001we-3G for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Nov 2004 00:40:23 -0800
Message-ID: <4189EAF2.6050007@vgertech.com>
From: Nuno Silva <nuno.silva@vgertech.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: Stop at startup on 2.6 NPTL hosts
References: <20041029092641.8558.qmail@web26102.mail.ukl.yahoo.com>	<200411021952.09095.blaisorblade_spam@yahoo.it>	<41884ACC.2020309@vgertech.com>
	<878y9jib8z.fsf@bytesex.org>
In-Reply-To: <878y9jib8z.fsf@bytesex.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Thu, 04 Nov 2004 08:40:18 +0000
To: Gerd Knorr <kraxel@bytesex.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

Gerd Knorr wrote:
> Nuno Silva <nuno.silva@vgertech.com> writes:
> 
> 
>>Yes, maybe it was me and, FWIW, I never found a solution to make a
>>dynamic skas uml run under 2.6+libcNTPL.
> 
> 
> The usual workaround for any nptl issues works here as well:
> export LD_ASSUME_KERNEL=2.4.21

I know that, but thanks for the info anyway. The reason to try UML with 
newer glibcs was to stop using int80 and use the vsyscall thing. Maybe I 
could save a few cycles! :-)

So using another glibc (by setting LD_ASSUME_KERNEL) is not what I want ;)

Regards,
Nuno Silva


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

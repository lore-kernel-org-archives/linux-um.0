Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPBS2-0000bT-Lz for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Nov 2004 19:04:46 -0800
Received: from adsl-b5-232-188.telepac.pt ([82.154.232.188]
	helo=puma-vgertech.no-ip.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CPBRy-0006Ml-3v for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Nov 2004 19:04:46 -0800
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by puma-vgertech.no-ip.com (Postfix) with ESMTP id 42700BA409A
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed,  3 Nov 2004 03:04:45 +0000 (WET)
Message-ID: <41884ACC.2020309@vgertech.com>
From: Nuno Silva <nuno.silva@vgertech.com>
MIME-Version: 1.0
References: <20041029092641.8558.qmail@web26102.mail.ukl.yahoo.com>
	<200411021952.09095.blaisorblade_spam@yahoo.it>
In-Reply-To: <200411021952.09095.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: Stop at startup on 2.6 NPTL hosts
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
Date: Wed, 03 Nov 2004 03:04:44 +0000
To: user-mode-linux-devel@lists.sourceforge.net

Blaisorblade wrote:

...

> This happens if and only if UML is using NPTL thread libraries. This, in turn, 
> happens in normal config with a NPTL-enabled glibc on the host, or in the 
> special situation of CONFIG_MODE_TT and CONFIG_STATIC_LINK off. This is why 
> it's not normally noticed and it's not yet debugged (it was reported the 1st 
> time by Nuno Silva around 2.6.0).

Yes, maybe it was me and, FWIW, I never found a solution to make a 
dynamic skas uml run under 2.6+libcNTPL.

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

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AuAbl-00017A-H3
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 20 Feb 2004 05:22:21 -0800
Received: from mailgate.uni-paderborn.de ([131.234.22.32])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AuAVu-0004IJ-6c
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 20 Feb 2004 05:16:18 -0800
Message-ID: <40360944.3030905@upb.de>
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
MIME-Version: 1.0
References: <40338C1B.1070800@meisterwerk.net> <c1360l$eei$1@sea.gmane.org> <87llmy3vr5.fsf@bytesex.org> <4035FDFE.6010402@upb.de> <20040220125413.GA15930@bytesex.org>
In-Reply-To: <20040220125413.GA15930@bytesex.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: skas3 patch fails against vanilla-2.4.25
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 20 Feb 2004 14:19:00 +0100
To: Gerd Knorr <kraxel@bytesex.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

>>The description of the second path was:
>>	Various fixups to make the whole tree build for all
>>	architectures.
>>
>>So i thought it is to make it compile on PPC or whatever.
> 
> "all architectures" includes both ppc and i386 ;)

OK, after applying the second patch, the kernel compiles again.


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

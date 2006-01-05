Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eud9V-0006R4-Vo for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Jan 2006 14:00:10 -0800
Received: from linux01.gwdg.de ([134.76.13.21] ident=root)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Eud9S-0007c9-MD
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Jan 2006 14:00:07 -0800
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
In-Reply-To: <20060105161436.GA4426@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.61.0601052258350.27662@yvahk01.tjqt.qr>
References: <200601042151.k04LpxbH009237@ccure.user-mode-linux.org>
	<Pine.LNX.4.61.0601050844550.10161@yvahk01.tjqt.qr>
	<20060105161436.GA4426@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Re: [PATCH 4/9] UML - Better diagnostics for broken
	configs
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
Date: Thu, 5 Jan 2006 22:59:58 +0100 (MET)
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

>> >Produce a compile-time error if both MODE_SKAS and MODE_TT are disabled.
>>
>> What would happen if both were disabled?
>> Say, if the host system does not have SKAS and I did not want any 
>> tracing/debugging stuff?
>
>You get a UML that can't run.  TT mode isn't tracing/debugging stuff.  It's 
>a basic mode of UML operation.  Also, UML doesn't need the skas patch on
>the host in order to use skas mode any more.  It helps, but is not necessary.

config MODE_TT
        bool "Tracing thread support"
        default y
        help
        This option controls whether tracing thread support is compiled
        into UML.  Normally, this should be set to Y.  If you intend to
        use only skas mode (and the host has the skas patch applied to it),
        then it is OK to say N here.

Then I unfortunately do not quite understand what this is for.



Jan Engelhardt
-- 


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

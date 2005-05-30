Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dcp74-0004uQ-Dq	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 May 2005 11:35:46 -0700
Received: from nepa.nlc.no ([195.159.31.6] ident=qmailr)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1Dcp72-0003N8-EJ	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 May 2005 11:35:46 -0700
Message-ID: <38187.82.164.126.70.1117478138.squirrel@82.164.126.70>
In-Reply-To: 
     <29D15BBCA340DA4D8146D38B4924FC7A105057@zcarhxm0.corp.nortel.com>
References: 
    <29D15BBCA340DA4D8146D38B4924FC7A105057@zcarhxm0.corp.nortel.com>
Subject: Re: [uml-devel] Slower system call with SMP
From: stian@nixia.no
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Date: Mon, 30 May 2005 20:35:38 +0200 (CEST)
To: Majid Salame <msalame@nortel.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

> Doe that make sense ? Doing the same test by disabling SMP on the host,
> and
> results are much faster.
> NOTE SMP is turned off for the UML.

This is a shot from the hip, but

UML uses multiple processes for it's buisness. When host is SMP, these can
be mapped to different cpu's, and when interprocess stuff is to occure,
cpu's have to sync.

Also, some few kernel things is slower on SMP, while user-space things
that are not related, and multithreaded apps run faster.

Stian


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

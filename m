Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CzCiK-00030u-RG for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 03:42:28 -0800
Received: from nepa.nlc.no ([195.159.31.6] ident=qmailr)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CzCiG-0004k3-Uo for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 03:42:28 -0800
Message-ID: <55690.80.203.9.134.1108035741.squirrel@80.203.9.134>
In-Reply-To: <200502101226.47978.blaisorblade@yahoo.it>
References: <A06801158AE07847B27A52C1A074BC1D0725A4D6@fmsmsx404.amr.corp.intel.com>
	<200502101226.47978.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] strace of 'ls' under Fedora Core 3
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
Date: Thu, 10 Feb 2005 12:42:21 +0100 (CET)
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, "Wichmann, Mats D" <mats.d.wichmann@intel.com>, Marion Bates <mbates@whoopis.com>, William Stearns <wstearns@pobox.com>

> Also, the code inside UML should absolutely support it (from the code I
> don't
> see any problem), at least for the x86 UML.

modify_ldt is a x86 syscall aswell, so it will only appear in x86/x86_64
umls. It was implemented and used by dosemu project originally.

What actually uses this syscall as I find the syscall to be badly
documented last time I looked at it.



Stian Skjelstad


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

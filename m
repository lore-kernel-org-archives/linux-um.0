Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ct2Sk-0007vS-TO for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Jan 2005 03:32:54 -0800
Received: from nepa.nlc.no ([195.159.31.6] ident=qmailr)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1Ct2Sj-0005KX-7e for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Jan 2005 03:32:54 -0800
Message-ID: <51673.80.203.0.208.1106566366.squirrel@80.203.0.208>
In-Reply-To: <41F4DC94.7030900@fujitsu-siemens.com>
References: <267988DEACEC5A4D86D5FCD780313FBB03B12C4B@exch-03.noida.hcltech.com>
	<200501240111.j0O1BtoI004687@ccure.user-mode-linux.org>
	<200501240010.23514.rob@landley.net>
	<Pine.LNX.4.61.0501241103350.5934@filer.marasystems.com>
	<41F4DC94.7030900@fujitsu-siemens.com>
Subject: Re: [uml-devel] memory
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
Date: Mon, 24 Jan 2005 12:32:46 +0100 (CET)
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: Henrik Nordstrom <uml@hno.marasystems.com>, Rob Landley <rob@landley.net>, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, "Vaibhav Sharma, Noida" <vaibhavs@noida.hcltech.com>, Doug Dumitru <doug@easyco.com>

> Linux needs to have one struct page for each physical mem page, which in
> the
> simple case of UML are placed in one memmap array.
> This array needs to be accessible permanently to the kernel, i.e. it
> has to be in low-mem. AFAIK, one struct page is 44 bytes in size, thus the
> array is about 1% of the entire physical mem in size.

You can mangle with the page-size as-well. You will break some few
programs by increasing the page-size too 16K instead of 4K, but most
software should respect the output mmap gives it, etc.


Stian


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

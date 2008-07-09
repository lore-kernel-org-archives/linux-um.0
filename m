Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KGTdt-0004Po-1c for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Jul 2008 23:59:09 -0700
Received: from mu-out-0910.google.com ([209.85.134.191])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KGTdq-0001Xv-VZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Jul 2008 23:59:08 -0700
Received: by mu-out-0910.google.com with SMTP id g7so1006615muf.2
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 08 Jul 2008 23:59:03 -0700 (PDT)
Message-ID: <39134b110807082359w4aca52a2m6910e8371a82c224@mail.gmail.com>
Date: Wed, 9 Jul 2008 14:59:02 +0800
From: "lianwei Wang" <lianwei.wang@gmail.com>
MIME-Version: 1.0
Subject: [SPAM]  [uml-devel] Question about Host PCI and DMA support in UML
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1606969894=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net

--===============1606969894==
Content-Type: multipart/alternative; 
	boundary="----=_Part_10580_10298729.1215586742958"

------=_Part_10580_10298729.1215586742958
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Jeff Dike,

I find from the UML website that the UML can access the host PCI device
accessing with VPCI patch, but it seem that that VPCI patch is too old. Do
you know that latest information about the VPCI patch? Is it stable? And
where could I find the patch?

From the below mail you say that you are trying to emulate the DMA using
iomem. How about the latest information of it?  And does it worked or not?


*Re: [uml-user] PCI & DMA
From: P. Thambi <uml_linux@ya...> - 2003-10-06 23:02
    --- Jeff Dike <jdike@ad...> wrote:
> uml_linux@ya... said:
> > Is there any other ways to emulate the PCI & DMA
> in uml other than
> > using iomems?
>
> There's Jon Smirl's VPCI patch for PCI. I don't
> know what you can do for
> DMA since any addresses that UML knows about will be
> virtual ones, and DMA
> has to be to physical addresses.

I looked at VPCI but it for actual PCI device access
in the x86 I believe. Yes DMA access needs using
physical address. But I am trying to emulate the DMA
using iomem. so I that I can some how map(emulate) the
register access/virtual->physical address in iomem
memory. I know to emulate the entire PPC processor is
a big task. But I dont have any other option because
hardware is little behind.

Thanks,
Lianwei
*

------=_Part_10580_10298729.1215586742958
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Jeff Dike,<br><br>I find from the UML website that the UML can access the host PCI device accessing with VPCI patch, but it seem that that VPCI patch is too old. Do you know that latest information about the VPCI patch? Is it stable? And where could I find the patch?<br>
<br>From the below mail you say that you are trying to emulate the DMA using iomem. How about the latest information of it?&nbsp; And does it worked or not?<br><br><br><i>Re: [uml-user] PCI &amp; DMA<br>From: P. Thambi &lt;uml_linux@ya...&gt; - 2003-10-06 23:02<br>
&nbsp;&nbsp;&nbsp; --- Jeff Dike &lt;jdike@ad...&gt; wrote:<br>&gt; uml_linux@ya... said:<br>&gt; &gt; Is there any other ways to emulate the PCI &amp; DMA<br>&gt; in uml other than<br>&gt; &gt; using iomems?<br>&gt;<br>&gt; There&#39;s Jon Smirl&#39;s VPCI patch for PCI. I don&#39;t<br>
&gt; know what you can do for<br>&gt; DMA since any addresses that UML knows about will be<br>&gt; virtual ones, and DMA<br>&gt; has to be to physical addresses.<br><br>I looked at VPCI but it for actual PCI device access<br>
in the x86 I believe. Yes DMA access needs using<br>physical address. But I am trying to emulate the DMA<br>using iomem. so I that I can some how map(emulate) the<br>register access/virtual-&gt;physical address in iomem<br>
memory. I know to emulate the entire PPC processor is<br>a big task. But I dont have any other option because<br>hardware is little behind.<br><br>Thanks,<br>Lianwei<br></i>

------=_Part_10580_10298729.1215586742958--


--===============1606969894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
--===============1606969894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1606969894==--


Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6s3z-00035o-6F for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Mar 2005 07:16:31 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1D6s3u-00005Q-91
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Mar 2005 07:16:31 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] UML freezes at hdd-intensive processes
References: <37436.128.176.89.137.1109846512.squirrel@128.176.89.137>
In-Reply-To: <37436.128.176.89.137.1109846512.squirrel@128.176.89.137>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503030858.18404.rob@landley.net>
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
Date: Thu, 3 Mar 2005 08:58:09 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Oliver Baltz <info@OliverBaltz.de>

On Thursday 03 March 2005 05:41 am, Oliver Baltz wrote:
> Hi @all,
>
> my UML hangs while intensive processes that use the HDD. For example:
> rgrep, upgrade,...
>
> UML-Hostsystem: 2.4.27-1-386, Intel ICH5 SATA 150-Controller
> UML: 2.4.26-3um-1
>
> Any ideas?

I haven't seen this on 2.6, but I think the first question is what kind of 
filesystem are you using?  Hostfs?  NFS?  UBD mount?

Rob


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

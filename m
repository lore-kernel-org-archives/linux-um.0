Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNCZq-0007xX-Ou for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 08:52:38 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CNCZn-00034C-PX for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 08:52:38 -0700
Message-ID: <41811488.50309@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] New breakout from UML
References: <417FBB39.30003@fujitsu-siemens.com> <877jpbrkrc.fsf@bytesex.org>
In-Reply-To: <877jpbrkrc.fsf@bytesex.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Thu, 28 Oct 2004 17:47:20 +0200
To: Gerd Knorr <kraxel@bytesex.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, BlaisorBlade <blaisorblade_spam@yahoo.it>

Gerd Knorr wrote:
> Bodo Stroesser <bstroesser@fujitsu-siemens.com> writes:
> 
> 
>>The attached patch should:
> 
> 
> What kernel this one should be applied to?  I've tried 2.6.9 + patches
> from sf.net -- doesn't work.  Seems there are some bits missing ...
> 
>   Gerd
> 
Yes. The kernel this applies to is 2.6.9 + latest incremental patches +
7 further patches from me. Maybe it's a bit tiresome to search them in
the mail archive.
Should I send them directly to you in a private mail? (Don't want to
send them to the list again...)

Please note: singlestepping doesn't work on a 2.6.9-skas3.v6 host in
SKAS using SYSEMU. There is an additional patch needed also.

Bodo


-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

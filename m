Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CtCte-0007Hr-3r for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Jan 2005 14:41:22 -0800
Received: from marasystems.com ([83.241.133.2] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CtCtc-0001rK-DN for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Jan 2005 14:41:22 -0800
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] memory
In-Reply-To: <200501242007.30317.blaisorblade@yahoo.it>
Message-ID: <Pine.LNX.4.61.0501242329420.22700@filer.marasystems.com>
References: <267988DEACEC5A4D86D5FCD780313FBB03B7317C@exch-03.noida.hcltech.com>
	<200501242007.30317.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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
Date: Mon, 24 Jan 2005 23:41:18 +0100 (CET)
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, "Vaibhav Sharma, Noida" <Vaibhavs@noida.hcltech.com>

On Mon, 24 Jan 2005, Blaisorblade wrote:

> You'd probably prefer to use the 4G/4G patch from Ingo Molnar, integrated into
> Fedora kernels, to allow processes to use 4G of virtual address space.

Side note: Fedora apparently dropped this patch some time ago, reason not 
known to me.

* Thu Dec 09 2004 Dave Jones <davej@redhat.com>

- Drop the 4g/4g hugemem kernel completely.

Regards
Henrik


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CtGeV-0001Pz-Cw for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Jan 2005 18:41:59 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CtGeU-0004et-Sk
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Jan 2005 18:41:59 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] memory
References: <267988DEACEC5A4D86D5FCD780313FBB03B7317C@exch-03.noida.hcltech.com>
	<200501242007.30317.blaisorblade@yahoo.it>
	<Pine.LNX.4.61.0501242329420.22700@filer.marasystems.com>
In-Reply-To: <Pine.LNX.4.61.0501242329420.22700@filer.marasystems.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501242040.20095.rob@landley.net>
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
Date: Mon, 24 Jan 2005 20:40:20 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Henrik Nordstrom <uml@hno.marasystems.com>, Blaisorblade <blaisorblade@yahoo.it>, "Vaibhav Sharma, Noida" <Vaibhavs@noida.hcltech.com>

On Monday 24 January 2005 05:41 pm, Henrik Nordstrom wrote:
> On Mon, 24 Jan 2005, Blaisorblade wrote:
> > You'd probably prefer to use the 4G/4G patch from Ingo Molnar, integrated
> > into Fedora kernels, to allow processes to use 4G of virtual address
> > space.
>
> Side note: Fedora apparently dropped this patch some time ago, reason not
> known to me.

Dell started shipping em64t systems, making it unanimous that their 
"enterprise" customers (only ones who ever cared) could use buy x86-64 
hardware.

Rob


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

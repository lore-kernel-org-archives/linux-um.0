Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWBnt-0007P8-HQ for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Nov 2004 02:52:17 -0800
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CWBnq-0004XH-L8
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Nov 2004 02:52:17 -0800
From: Martin Waitz <tali@admingilde.org>
Message-ID: <20041122104806.GI19738@admingilde.org>
References: <1100613788.24599.45.camel@imp.csi.cam.ac.uk>
	<200411180148.iAI1mGQ3006498@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411180148.iAI1mGQ3006498@ccure.user-mode-linux.org>
Subject: [uml-devel] Re: And another bug report for UML in latest Linux 2.6-BK
	repository.
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
Date: Mon, 22 Nov 2004 11:48:06 +0100
Content-Transfer-Encoding: 8bit
To: Jeff Dike <jdike@addtoit.com>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, user-mode-linux-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>

hoi :)

On Wed, Nov 17, 2004 at 08:48:16PM -0500, Jeff Dike wrote:
> aia21@cam.ac.uk said:
> > sleeping process 29410 got unexpected signal : 11
> > I now have to press Ctrl+C to get back to my shell. 
> 
> This one is slightly subtle, but I believe that it is fixed by the following 
> patch.

It fixes the problem for me. Please send the patch to Linus.

-- 
Martin Waitz


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

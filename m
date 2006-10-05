Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GVav9-0006AB-94 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Oct 2006 14:38:23 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GVav6-0001ND-QW
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Oct 2006 14:38:23 -0700
Date: Thu, 5 Oct 2006 17:36:33 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20061005213633.GB6790@ccure.user-mode-linux.org>
References: <11600768683307-git-send-email-blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <11600768683307-git-send-email-blaisorblade@yahoo.it>
Subject: Re: [uml-devel] uml: allow using again x86/x86_64 crypto code
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: stable@kernel.org, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 09:34:28PM +0200, Paolo 'Blaisorblade' Giarrusso wrote:
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> Enable compilation of x86_64 crypto code;, and add the needed constant to make
> the code compile again (that macro was added to i386 asm-offsets between 2.6.17
> and 2.6.18, in 6c2bb98bc33ae33c7a33a133a4cd5a06395fece5).
> 
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Acked-by: Jeff Dike <jdike@addtoit.com>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

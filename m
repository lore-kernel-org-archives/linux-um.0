Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FyyAA-0005OO-HF for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Jul 2006 14:47:02 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1FyyAA-000763-2y
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Jul 2006 14:47:02 -0700
Date: Fri, 7 Jul 2006 14:50:23 -0700
From: Andrew Morton <akpm@osdl.org>
Message-Id: <20060707145023.2edfd763.akpm@osdl.org>
In-Reply-To: <200607070033.k670XXqc008662@ccure.user-mode-linux.org>
References: <200607070033.k670XXqc008662@ccure.user-mode-linux.org>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH 1/19] UML - Clean up address space limits code
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
To: Jeff Dike <jdike@addtoit.com>
Cc: tyler@agat.net, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Jeff Dike <jdike@addtoit.com> wrote:
>
> I was looking at the code of the UML and more precisely at the functions
> set_task_sizes_tt and set_task_sizes_skas. I noticed that these 2
> functions take a paramater (arg) which is not used : the function is
> always called with the value 0.
> 
> I suppose that this value might change in the future (or even can be
> configured), so I added a constant in mem_user.h file.
> 
> Also, I rounded CONFIG_HOST_TASk_SIZE to a 4M.
> 
> Signed-off-by: Tyler <tyler@agat.net>
> Signed-off-by: Jeff Dike <jdike@addtoit.com>

I'll assume this patch was authored by Tyler <tyler@agat.net>

Please use a "From: " line right at the start of the email/changelog to indicate
authorship, thanks.


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

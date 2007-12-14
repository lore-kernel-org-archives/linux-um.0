Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J3ENw-0000d8-MN for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 Dec 2007 09:31:40 -0800
Received: from ruby.spiritone.com ([216.99.193.130])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J3ENv-0000Ja-Ce
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 Dec 2007 09:31:40 -0800
Received: from [192.168.0.4] (216-99-213-225.dsl.aracnet.com [216.99.213.225])
	(authenticated bits=0)
	by ruby.spiritone.com (8.13.6/8.13.4) with ESMTP id lBEHVJK6010490
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 14 Dec 2007 09:31:29 -0800
Message-ID: <4762BDEF.2040003@BitWagon.com>
Date: Fri, 14 Dec 2007 09:31:27 -0800
From: John Reiser <jreiser@BitWagon.com>
MIME-Version: 1.0
Subject: [uml-devel] Why does mem_init call map_cb twice?
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

In arch/um/kernel/mem.c, mem_init calls map_cb twice:
once directly and once indirectly via initial_thread_cb.  Why?

-----
void mem_init(void)
{
        /* clear the zero-page */
        memset((void *) empty_zero_page, 0, PAGE_SIZE);

        /* Map in the area just after the brk now that kmalloc is about
         * to be turned on.
         */
        brk_end = (unsigned long) UML_ROUND_UP(sbrk(0));
        map_cb(NULL);
        initial_thread_cb(map_cb, NULL);
-----

-- 
John Reiser, jreiser@BitWagon.com

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

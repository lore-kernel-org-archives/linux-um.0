Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H7DBJ-0004kH-Sf for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Jan 2007 07:58:33 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1H7DBB-00083N-IZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Jan 2007 07:58:32 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Wed, 17 Jan 2007 16:57:31 +0100
References: <200701171159003590471@software.ict.ac.cn>
	<200701171318597188349@software.ict.ac.cn>
In-Reply-To: <200701171318597188349@software.ict.ac.cn>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200701171657.31546.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] I met a question in building the root_fs of UML
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Qin An <qinan@software.ict.ac.cn>

On Wednesday 17 January 2007 06:19, Qin An wrote:
> Hi wstearns,
>
> I now use the UML to do my jobs. However, it is my first time to use the
> system, and met a problem in building my own root_fs.

> I downloaded the scripts in http://www.stearns.org/mkrootfs/ and run the
> commands
>
> # ./mkrootfs
>
> It run not very well but  finially finished and got a file 'root_fs'. I
> booted the UML using the file.
>
> # linux ubd0=root_fs
>
> It was so pity that it didn't work and said:
>
> Kernel panic - not syncing: No init found.  Try passing init= option to
> kernel.

Then the root_fs built wasn't correct. Loop mount it and look to see what 
happened.

We cannot diagnose why without the error messages, but I'm not sure whether 
mkrootfs still works well, and I cannot say whether UML boots at all there 
(there are buggy releases out there).

> How to do next? Could you give me some advices?

Download a pre-built root_fs from here:
http://uml.nagafix.co.uk/
Or follow the installation log of your chosen root_fs and follow it.

> Thanks a lot~
>
> -------------
> Qin An
> 2007-01-17
>
> Research Center for Grid and Service Computing
> Institute of Computing Technology, Chinese Academy of Sciences
> P.O.Box 2704, 100080, Beijing, China
> Tel: 86-10-62600974
> Email: qinan@software.ict.ac.cn

-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ALh87-0003vg-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 17 Nov 2003 03:01:15 -0800
Received: from [62.94.208.107] (helo=mancillotti.retesintesi.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1ALh7U-0003g9-36
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 17 Nov 2003 03:00:36 -0800
From: marco ancillotti <mancillotti@interfree.it>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1069066776.2109.12.camel@mancillotti.retesintesi.net>
Mime-Version: 1.0
Subject: [uml-devel] high memory problem
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: 17 Nov 2003 11:59:36 +0100
To: user-mode-linux-devel@lists.sourceforge.net

hi all,

there's a way to get a uml 2.4 kernel with support for highmem ?
i've try last patch , but if I compile with highmem enable i get compile
error , i've try with a 2.6 and is working , but i've need a 2.4 to make
some performance test with large db.

thank's


-- 
----------------------------------------------------

Marco Ancillotti 
uniX / Linux Tecnical specialist

- IBM Aix Certified Advanced Tecnical Specialist
- IBM Enterprise storage specialist
- Red Hat Certified Engineer

    Lpar manager first developer and mantainer.
( http://savannah.nongnu.org/projects/lparmanager )

S.in.te.si. srl
via cecchi 28
50053 Empoli (FI)
tel: 0571/72400
fax: 0571/72064

m.ancillotti@retesintesi.it
cell: 347/3460086

----------------------------------------------------
-- 
----------------------------------------------------

Marco Ancillotti 
uniX / Linux Tecnical specialist

- IBM Aix Certified Advanced Tecnical Specialist
- IBM Enterprise storage specialist
- Red Hat Certified Engineer

    Lpar manager first developer and mantainer.
( http://savannah.nongnu.org/projects/lparmanager )

S.in.te.si. srl
via cecchi 28
50053 Empoli (FI)
tel: 0571/72400
fax: 0571/72064

m.ancillotti@retesintesi.it
cell: 347/3460086

----------------------------------------------------


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19ud7K-0005qy-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 03 Sep 2003 12:16:34 -0700
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19ud7K-0004Hj-FE
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 03 Sep 2003 12:16:34 -0700
Received: from 216-15-124-77.c3-0.smr-ubr3.sbo-smr.ma.cable.rcn.com ([216.15.124.77] helo=mizar.alcor.net)
	by smtp01.mrf.mail.rcn.net with esmtp (Exim 3.35 #4)
	id 19ud7J-0005nT-00
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 03 Sep 2003 15:16:33 -0400
Received: from mdz by mizar.alcor.net with local (Exim 3.36 #1 (Debian))
	id 19ud7J-0003LA-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 03 Sep 2003 15:16:33 -0400
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] hostfs as root
Message-ID: <20030903191633.GV7304@alcor.net>
References: <1062581538.15476.4.camel@henrik.marasystems.com> <18250.1062613374@marajade.sandelman.ottawa.on.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18250.1062613374@marajade.sandelman.ottawa.on.ca>
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
Date: Wed, 3 Sep 2003 15:16:33 -0400
To: user-mode-linux-devel@lists.sourceforge.net

On Wed, Sep 03, 2003 at 02:22:54PM -0400, Michael Richardson wrote:

> >>>>> "Henrik" == Henrik Nordstrom <hno@marasystems.com> writes:
>     >> /etc/mtab~ is created with mode 0, and this shows up in the host that
>     >> way 
>     >> as well. Perhaps this is the real problem.
> 
>     Henrik> Right.. hostfs will almost certainly not work well with file mode 0
>     Henrik> until the virtual permissions layer is implemented.
> 
>     Henrik> Today hostfs directly maps permissions to the host files, which
>     Henrik> breaks 
> 
>   But, did this change between 2.4.19-47 and 2.4.20-8?
> 
>   2.4.19 works just fine.

Yes, it did.  Things were changed so that files could be created read-only
with O_RDWR.

-- 
 - mdz


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zowB-00066h-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 17 Sep 2003 19:54:31 -0700
Received: from cyrus.vandervecken.com ([64.124.43.248])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19zowB-00006w-AS
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 17 Sep 2003 19:54:31 -0700
Received: from geoff by cyrus.vandervecken.com with local (Exim 3.35 #1 (Debian))
	id 19zovb-0001Cd-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 17 Sep 2003 19:53:55 -0700
From: Geoff Thorpe <geoff@geoffthorpe.net>
Subject: Re: [uml-devel] Little heap overflow in mconsole_kern.c
References: <200309161559.18993.blaisorblade_spam@yahoo.it> <200309180022.h8I0MVNu021681@ccure.karaya.com>
In-Reply-To: <200309180022.h8I0MVNu021681@ccure.karaya.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309172253.58265.geoff@geoffthorpe.net>
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
Date: Wed, 17 Sep 2003 22:53:58 -0400
To: user-mode-linux-devel@lists.sourceforge.net

On September 17, 2003 08:22 pm, Jeff Dike wrote:
> blaisorblade_spam@yahoo.it said:
> > While new points to a mconsole_entry, the code allocates
> > sizeof(mc_request),  not sizeof(mconsole_entry)
>
> Gawd, someone really needs to shoot me before I destroy something...

Don't feel bad, I've come down with this bug a few times.

> BTW, It would be a good exercise for someone to go through the code and
> replace instances of
> 	foo = kmalloc(sizeof(type-name), ...)
> with
> 	foo = kmalloc(sizeof(*foo), ...)
>
> That would have prevented this bug.

FWIW: after having this problem one too many times with malloc and 
friends, I started using macros of the form;
  #define MYMALLOC(t,n)  (t *)malloc((n) * sizeof(t))
  #define MYFREE(t,p)    do { \
                             t *_tmp_4567 = (p); \
                             free(_tmp_4567); \
                         } while(0)
These get compiled down to malloc() and free(), respectively. However 
MYMALLOC has the compilation-time advantage of being typesafe according 
to the return value (not void*) and size (which matches the return type). 
The free() variant may seem a bit overkill, but tastes vary. Anyway, if 
you adopt something like this then you can consider any direct use of 
'malloc' and 'free' in the source as bugs and your audit becomes quite a 
bit easier. $0.02, etc.

Cheers,
Geoff

-- 
Geoff Thorpe
geoff@geoffthorpe.net
http://www.geoffthorpe.net/



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

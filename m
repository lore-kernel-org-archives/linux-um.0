Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DD8rG-0002Vq-Vf for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Mar 2005 14:25:18 -0800
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DD8rF-0004tW-K6
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Mar 2005 14:25:18 -0800
Received: from sphinx.mythic-beasts.com ([212.69.37.6])
	by externalmx-1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1DD8rC-00041d-RJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Mar 2005 14:25:15 -0800
From: Paul Warren <pdw@ex-parrot.com>
Subject: Re: [uml-devel] Re: [uml-user] uml help __alloc_pages: 0-order
	allocation failed (gfp=0xf0/0)
Message-ID: <20050320222507.B15902@sphinx.mythic-beasts.com>
References: <000d01c52b22$8ab2c020$0201a8c0@lualele>
	<000501c52b25$717710e0$0201a8c0@lualele>
	<20050317192527.GA15619@taniwha.stupidest.org>
	<200503172049.39200.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <200503172049.39200.blaisorblade@yahoo.it>;
	from blaisorblade@yahoo.it on Thu, Mar 17, 2005 at 08:49:38PM
	+0100
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
Date: Sun, 20 Mar 2005 22:25:07 +0000
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Chris Wedgwood <cw@f00f.org>, itamar <itamar@ispbrasil.com.br>


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[ trimmed cc to just -devel list]

On Thu, Mar 17, 2005 at 08:49:38PM +0100, Blaisorblade wrote:
> Paul Warren said that there is a leak in 2.4 UML related to hostfs stuff.. and 
> I already saw this message from some 2.4 recent UMLs. I hope Paul Warren can 
> explain what he saw and help us...
> 
> In case we have confirmation it's hostfs-related, we only need to go back to 
> the stable 2.4.24-1um hostfs code (i.e. pre-humfs), as I already do in the 
> 2.4-bs tree.

OK, our setup is that we have a load of distribution mirrors that are
NFS mounted onto the host server.  The guests then mount these using
hostfs.  We first noticed that a nightly updatedb was causing the amount
of memory that could be malloced to decrease.  We found that doing a
"find" across the entire hostfs mount also did the trick.

I've attached the script and program that we used to meause the maximum
amount of memory that can be malloced.  We then ran:

	while : ; do ./maxalloc ; updatedb ; done

... and watched the memory leak away.

Please let me know if you want some more info.

Paul

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=maxalloc

#!/bin/sh
hi=64
lo=1
while [ $[ $hi - $lo ] -gt 1 ] ; do
    mid=$[ ($hi + $lo) / 2 ]
    echo -n "trying $mid MB..."
    if /tmp/alloc $[ $mid * 1024 * 1024 ] ; then
        lo=$mid
        echo "OK"
    else
        hi=$mid
    fi
    echo "$lo $hi $[ $hi - $lo ]"
done
echo $hi MB

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="alloc.c"

#include <sys/types.h>
#include <stdlib.h>
#include <stdio.h>

int main(int argc, char *argv[]) {
    size_t amt;
    char *a, *p;
    if (argv[1]) amt = (size_t)atoi(argv[1]);
    else amt = 1024 * 1024;
    if (!(a = malloc(amt))) {
        fprintf(stderr, "failed to malloc %u bytes\n", amt);
        return 1;
    }
    for (p = a; p < a + amt; ++p) *p = (char)p;
    return 0;
}

--OXfL5xGRrasGEqWY--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

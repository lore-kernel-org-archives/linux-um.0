Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D0Oqd-0004tR-69 for User-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Feb 2005 10:51:59 -0800
Received: from smtp111.mail.sc5.yahoo.com ([66.163.170.9])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1D0Oqb-0005FM-Ol for User-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Feb 2005 10:51:59 -0800
References: <opsl43d9yilfdzum@localhost.localdomain>
	<200502131813.j1DICsnW002251@ccure.user-mode-linux.org>
	<20050213164652.GE8859@parcelfarce.linux.theplanet.co.uk>
From: "Vadim Abrossimov" <vadim_abrossimov@yahoo.com>
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <opsl5gb1holfdzum@localhost.localdomain>
In-Reply-To: <20050213164652.GE8859@parcelfarce.linux.theplanet.co.uk>
Subject: [uml-devel] Re: [PATCH] uml: support a separate build tree;
	support USER_OBJS dependencies
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
Date: Sun, 13 Feb 2005 19:58:39 +0100
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Jeff Dike <jdike@addtoit.com>
Cc: User-mode-linux-devel@lists.sourceforge.net

Following up the dicussion started on the linux-kernel list.

On Sun, 13 Feb 2005 16:46:52 +0000, Al Viro  
<viro@parcelfarce.linux.theplanet.co.uk> wrote:
> Err...  FWIW, aforementioned patch lacks e.g. vmlinux.lds.S.  The latest
> I have on anonftp is ftp.linux.org.uk/pub/people/viro/UML-kbuild; there's
> more in my local tree, but that's a separate story.

Apparently my changes to support 'O=' are quite obsolete: I was not aware  
about
the pending patches on http://user-mode-linux.sourceforge.net/patches.html  
and about
this mailing list dedicated to the uml development to which I have just  
subscribed.
Now I'm aware :->

The second change proposed in my patch concerned USER_OBJS dependences:
I removed specific rules using the generic Kbuild rule just overwriting  
'c_flags':

-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
+$(USER_OBJS) : c_flags = -Wp,-MD,$(depfile) $(CFLAGS_$(notdir $@))  
$(USER_CFLAGS)
+

I agree that it's not very elegant and robust but it does the job and  
could be useful until
Kbuild will provide a clean way to do it.

If you think useful, I may create a patch with this change only.
Should I do it against 2.6.10 as an add-on to the  
http://user-mode-linux.sourceforge.net/patches.html
tarball?

That lead me to another question: why we don't use directly BitKeeper? We  
could have a repository for uml
development.

Dima




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

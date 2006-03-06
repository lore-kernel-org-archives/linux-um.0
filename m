Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FG6Lt-0000fe-6S for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 05 Mar 2006 19:25:41 -0800
Received: from nproxy.gmail.com ([64.233.182.201])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FG6Ls-00041l-O5
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 05 Mar 2006 19:25:41 -0800
Received: by nproxy.gmail.com with SMTP id l36so747569nfa
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 05 Mar 2006 19:25:38 -0800 (PST)
Message-ID: <39134b110603051925y6f6176ffw@mail.gmail.com>
From: "wang lianwei" <lianwei.wang@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_1909_8734615.1141615537912"
Subject: [uml-devel] patch for iomem uses
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
Date: Mon, 6 Mar 2006 11:25:37 +0800
To: user-mode-linux-devel@lists.sourceforge.net
Cc: jdike@addtoit.com

------=_Part_1909_8734615.1141615537912
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

1. linux/arch/um/kernel/physmem.c

    the find_iomem function will case endless loop if you use two or more
iomem to launch the UML kernel.

    diff -urN linux-2.6.10/arch/um/kernel/physmem.c linux-2.6.10-src
/arch/um/kernel/physmem.c
    --- linux-2.6.10/arch/um/kernel/physmem.c 2004-12-25 05:35:01.000000000=
+0800
    +++ linux-2.6.10-src/arch/um/kernel/physmem.c 2006-02-21 13:22:
43.000000000 +0800
    @@ -275,7 +275,7 @@
      highmem_len =3D highmem_pages * sizeof(struct page);

      total_pages =3D phys_pages + iomem_pages + highmem_pages;
    - total_len =3D phys_len + iomem_pages + highmem_len;
    + total_len =3D phys_len + iomem_len + highmem_len;

      if(kmalloc_ok){
       map =3D kmalloc(total_len, GFP_KERNEL);
    @@ -435,6 +435,7 @@
        *len_out =3D region->size;
        return(region->virt);
       }
    +  region =3D region->next;
      }

      return(0);


2. /arch/um/kernel/mem_user.c

diff -urN linux-2.6.10/arch/um/kernel/mem_user.c linux-2.6.10-src
/arch/um/kernel/mem_user.c
--- linux-2.6.10/arch/um/kernel/mem_user.c 2004-12-25 05:34:57.000000000+08=
00
+++ linux-2.6.10-src/arch/um/kernel/mem_user.c 2006-02-21
16:17:39.000000000+0800
@@ -191,7 +191,7 @@
   goto out_close;
  }

- size =3D (buf.ust_size + UM_KERN_PAGE_SIZE) & ~(UM_KERN_PAGE_SIZE - 1);
+ size =3D (buf.ust_size + UM_KERN_PAGE_SIZE - 1 ) & ~(UM_KERN_PAGE_SIZE - =
1);

  *new =3D ((struct iomem_region) { .next  =3D iomem_regions,
      .driver  =3D driver,

------=_Part_1909_8734615.1141615537912
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>1. linux/arch/um/kernel/physmem.c </div>
<div>&nbsp;&nbsp;&nbsp; </div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;the find_iomem function&nbsp;will case endless=
 loop if you&nbsp;use two or more iomem to launch the UML kernel.&nbsp;&nbs=
p; </div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp;&nbsp; diff -urN linux-2.6.10/arch/um/kernel/physmem.c lin=
ux-2.6.10-src/arch/um/kernel/physmem.c<br>&nbsp;&nbsp;&nbsp; --- linux-2.6.=
10/arch/um/kernel/physmem.c&nbsp;2004-12-25 05:35:01.000000000 +0800<br>&nb=
sp;&nbsp;&nbsp; +++ linux-2.6.10-src/arch/um/kernel/physmem.c&nbsp;2006-02-=
21 13:22:
43.000000000 +0800<br>&nbsp;&nbsp;&nbsp; @@ -275,7 +275,7 @@<br>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; highmem_len =3D highmem_pages * sizeof(struct page);<br=
>&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;total_pages =3D phys_pages + iome=
m_pages + highmem_pages;<br>&nbsp;&nbsp;&nbsp; -&nbsp;total_len =3D phys_le=
n + iomem_pages + highmem_len;
<br>&nbsp;&nbsp;&nbsp; +&nbsp;total_len =3D phys_len + iomem_len + highmem_=
len;<br>&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(kmalloc_ok){<br>&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; map =3D kmalloc(total_len, GFP_KERNEL);<br>&n=
bsp;&nbsp;&nbsp; @@ -435,6 +435,7 @@<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; *len_out =3D region-&gt;size;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; return(region-&gt;virt);
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; +&nbsp;&nb=
sp;region =3D region-&gt;next;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp=
;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return(0);</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>2. /arch/um/kernel/mem_user.c</div>
<div>&nbsp;&nbsp;&nbsp; </div>
<div>diff -urN linux-2.6.10/arch/um/kernel/mem_user.c linux-2.6.10-src/arch=
/um/kernel/mem_user.c<br>--- linux-2.6.10/arch/um/kernel/mem_user.c&nbsp;20=
04-12-25 05:34:57.000000000 +0800<br>+++ linux-2.6.10-src/arch/um/kernel/me=
m_user.c&nbsp;2006-02-21 16:17:
39.000000000 +0800<br>@@ -191,7 +191,7 @@<br>&nbsp;&nbsp;&nbsp;goto out_clo=
se;<br>&nbsp;&nbsp;}<br>&nbsp;<br>-&nbsp;size =3D (buf.ust_size + UM_KERN_P=
AGE_SIZE) &amp; ~(UM_KERN_PAGE_SIZE - 1);<br>+&nbsp;size =3D (buf.ust_size =
+ UM_KERN_PAGE_SIZE - 1 ) &amp; ~(UM_KERN_PAGE_SIZE - 1);
<br>&nbsp;<br>&nbsp;&nbsp;*new =3D ((struct iomem_region) { .next&nbsp;&nbs=
p;=3D iomem_regions,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.driver&nbsp;&n=
bsp;=3D driver,</div>
<div>&nbsp;</div>
<div>&nbsp;</div>

------=_Part_1909_8734615.1141615537912--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

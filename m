Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EwKGS-0003jR-Nh for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Jan 2006 06:14:20 -0800
Received: from nproxy.gmail.com ([64.233.182.196])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EwKGS-0000Pw-93
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Jan 2006 06:14:20 -0800
Received: by nproxy.gmail.com with SMTP id a27so36392nfc
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 10 Jan 2006 06:14:16 -0800 (PST)
Message-ID: <39134b110601100614o14112d19r@mail.gmail.com>
From: wang lianwei <lianwei.wang@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_27316_585131.1136902456422"
Subject: [uml-devel] The init_maps bug which cause mem map error
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
Date: Tue, 10 Jan 2006 22:14:16 +0800
To: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

------=_Part_27316_585131.1136902456422
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

 There is a bug In file
    linux/arch/um/kernel/physmem.c  init_mem() functions:

*int* *init_maps*(*unsigned* *long* physmem, *unsigned* *long* iomem,
*unsigned* *long* highmem)
{
=09*struct* page *p, *map;
=09*unsigned* *long* phys_len, phys_pages, highmem_len, highmem_pages;
=09*unsigned* *long* iomem_len, iomem_pages, total_len, total_pages;
=09*int* i;

=09phys_pages =3D physmem >> PAGE_SHIFT;
=09phys_len =3D phys_pages * *sizeof*(*struct* page);

=09iomem_pages =3D iomem >> PAGE_SHIFT;
=09iomem_len =3D iomem_pages * *sizeof*(*struct* page);

=09highmem_pages =3D highmem >> PAGE_SHIFT;
=09highmem_len =3D highmem_pages * *sizeof*(*struct* page);

=09total_pages =3D phys_pages + iomem_pages + highmem_pages;
=09total_len =3D phys_len + iomem_pages + highmem_len;

=09*if*(kmalloc_ok){
=09=09map =3D kmalloc(total_len, GFP_KERNEL);
=09=09*if*(map =3D=3D NULL)
=09=09=09map =3D vmalloc(total_len);
=09}
=09*else* map =3D alloc_bootmem_low_pages(total_len);

=09*if*(map =3D=3D NULL)
=09=09*return*(-ENOMEM);

=09*for*(i =3D 0; i < total_pages; i++){
=09=09p =3D &map[i];
=09=09set_page_count(p, 0);
=09=09SetPageReserved(p);
=09=09INIT_LIST_HEAD(&p->list);
=09}

=09mem_map =3D map;
=09max_mapnr =3D total_pages;
=09*return*(0);
}

this line should be

total_len =3D phys_len + iomem_len + highmem_len;


 <http://cvs.sourceforge.net/viewcvs.py/user-mode-linux/linux/#dirlist>

------=_Part_27316_585131.1136902456422
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

 There is a bug In file<br>
&nbsp;&nbsp;&nbsp; linux/arch/um/kernel/physmem.c&nbsp; init_mem() function=
s:<br>
<br>
<pre><font color=3D"#228b22"><b>int</b></font> <b><font color=3D"#0000ff">i=
nit_maps</font></b>(<font color=3D"#228b22"><b>unsigned</b></font> <font co=
lor=3D"#228b22"><b>long</b></font> physmem, <font color=3D"#228b22"><b>unsi=
gned</b>
</font> <font color=3D"#228b22"><b>long</b></font> iomem, <font color=3D"#2=
28b22"><b>unsigned</b></font> <font color=3D"#228b22"><b>long</b></font> hi=
ghmem)<br>{<br>=09<font color=3D"#228b22"><b>struct</b></font> page *p, *ma=
p;<br>
=09<font color=3D"#228b22"><b>unsigned</b></font> <font color=3D"#228b22"><=
b>long</b></font> phys_len, phys_pages, highmem_len, highmem_pages;<br>=09<=
font color=3D"#228b22"><b>unsigned</b></font> <font color=3D"#228b22"><b>lo=
ng</b></font>
 iomem_len, iomem_pages, total_len, total_pages;<br>=09<font color=3D"#228b=
22"><b>int</b></font> i;<br><br>=09phys_pages =3D physmem &gt;&gt; PAGE_SHI=
FT;<br>=09phys_len =3D phys_pages * <b><font color=3D"#a020f0">sizeof</font=
></b>(<font color=3D"#228b22">
<b>struct</b></font> page);<br><br>=09iomem_pages =3D iomem &gt;&gt; PAGE_S=
HIFT;<br>=09iomem_len =3D iomem_pages * <b><font color=3D"#a020f0">sizeof</=
font></b>(<font color=3D"#228b22"><b>struct</b></font> page);<br><br>=09hig=
hmem_pages =3D highmem &gt;&gt; PAGE_SHIFT;
<br>=09highmem_len =3D highmem_pages * <b><font color=3D"#a020f0">sizeof</f=
ont></b>(<font color=3D"#228b22"><b>struct</b></font> page);<br><br>=09tota=
l_pages =3D phys_pages + iomem_pages + highmem_pages;<br>=09<span style=3D"=
font-weight: bold;">
total_len =3D phys_len + <span style=3D"background-color: rgb(255, 0, 0);">=
iomem_pages</span> + highmem_len;</span><br><br>=09<b><font color=3D"#a020f=
0">if</font></b>(kmalloc_ok){<br>=09=09map =3D kmalloc(total_len, GFP_KERNE=
L);<br>=09=09<b>
<font color=3D"#a020f0">if</font></b>(map =3D=3D NULL) <br>=09=09=09map =3D=
 vmalloc(total_len);<br>=09}<br>=09<b><font color=3D"#a020f0">else</font></=
b> map =3D alloc_bootmem_low_pages(total_len);<br><br>=09<b><font color=3D"=
#a020f0">if</font></b>
(map =3D=3D NULL)<br>=09=09<b><font color=3D"#a020f0">return</font></b>(-EN=
OMEM);<br><br>=09<b><font color=3D"#a020f0">for</font></b>(i =3D 0; i &lt; =
total_pages; i++){<br>=09=09p =3D &amp;map[i];<br>=09=09set_page_count(p, 0=
);<br>=09=09SetPageReserved(p);
<br>=09=09INIT_LIST_HEAD(&amp;p-&gt;list);<br>=09}<br><br>=09mem_map =3D ma=
p;<br>=09max_mapnr =3D total_pages;<br>=09<b><font color=3D"#a020f0">return=
</font></b>(0);<br>}<br><br></pre>
this line should be&nbsp; <br>
<pre><span style=3D"font-weight: bold;">total_len =3D phys_len + <span styl=
e=3D"background-color: rgb(255, 255, 255); color: rgb(102, 51, 255);">iomem=
_len</span> + highmem_len;</span></pre>
<a href=3D"http://cvs.sourceforge.net/viewcvs.py/user-mode-linux/linux/#dir=
list"><br>
</a>

------=_Part_27316_585131.1136902456422--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

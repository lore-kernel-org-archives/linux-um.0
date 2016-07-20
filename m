Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1bPvIz-0001Ja-MB
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Jul 2016 17:29:09 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92]
	helo=www.kot-begemot.co.uk)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1bPvIy-00043d-4q
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Jul 2016 17:29:09 +0000
In-Reply-To: <1469034268.11733.10.camel@debian.org>
References: <1469034268.11733.10.camel@debian.org>
MIME-Version: 1.0
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Date: Wed, 20 Jul 2016 19:28:50 +0200
Message-ID: <E154B48D-5852-4676-A86D-E3A3FC510740@kot-begemot.co.uk>
Subject: Re: [uml-devel] User Mode Linux
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1230614667475915847=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: rrs@debian.org, jdike@addtoit.com, richard@nod.at
Cc: Mattia Dongili <malattia@linux.it>, user-mode-linux-devel@lists.sourceforge.net

--===============1230614667475915847==
Content-Type: multipart/alternative;
	boundary="----RG0RDWGJ5O9LCSE8O8PR3JVQD6SI41"
Content-Transfer-Encoding: 8bit

------RG0RDWGJ5O9LCSE8O8PR3JVQD6SI41
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"

I have some patches which bring network performance to > 3gbit for a single core virtual router/firewall/net device, need to find time to get them up to date and resubmit.
Some disk is improvements too.

On 20 July 2016 19:04:28 CEST, Ritesh Raj Sarraf <rrs@debian.org> wrote:
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA512
>
>Hello Jeff, Richard and the UML Team.
>
>Me and Mattia are maintainers for UML in the Debian Distribution.
>
>Recently, during a refresh of the package, we realized that the User
>Mode Linux
>website, which hosts useful documentation, doesn't seem to have been
>updated in
>years.
>
>The documentation which still is active and useful[1] is marked as
>"old" on the
>website.
>The wiki [2] on the other hand, points to a link with no content at
>all.
>
>Could you please share on what the roadmap and future plans for UML
>are?
>And for the documentation on the old site, do you have it in a Source
>Markup
>Language? What we've used now is a dump of the website from [1]
>
>[1] http://user-mode-linux.sourceforge.net/old/
>[2] http://uml.harlowhill.com/
>
>- -- 
>Ritesh Raj Sarraf | http://people.debian.org/~rrs
>Debian - The Universal Operating System
>-----BEGIN PGP SIGNATURE-----
>
>iQIcBAEBCgAGBQJXj68dAAoJEKY6WKPy4XVpDEMQAJuzJVT9z2KMLYl+69RSe1wL
>VHbrT23TPVEuIBMFPxpilSbJcTGAg9XA/WJ/h+xONzAQ14rKBsoJFAvPGkZHJHsf
>aNSXNU4fI2EEPNoYCocZnQwbuReeI4up8BnIX9KxuSOmOJirbkC88YG9EfmmpjSG
>Nm8nJFZdXa8psXz7zfxH1BZyMTWDwaqfKfxvwQmrA4s0FjUY8pL/2ggEggLRsClR
>8lzxsvzs1Zt/1+wostGYCqXRfQBKfyHBUlrBBsI2GhxjEndZHQTkxR8iWCSzfAZg
>mydkz1uEDyme3Op+rSOyRgO9DTlNdnczM9/6rL6Zs4CEDyy0Xowk0BZBTV0Bd3Bw
>U5WvjgEEnyvGsmvSyY0wj7A+FdRWnlRJrCanRlPSLc1iuJAgebDDRyL7qmVIaW9Z
>JJrOgH+NLo7Yer7xpOn7esChu7Gjw1kO6IFsD9xqMVsCy5ByPMPqpDrfL5SFhMPo
>CycOalMupTjT4rRR9ocMF7XebCLIIxAT0Rvwvmyk4gbYryZZlT6pKDTe9XzmHgCN
>EMs9t8kxle0hSDT+z2FE9w5/6b6cYbAALRe305n/Xy8GmGwA1bZ/xJC761JB+TlG
>xq5jl94T9rhqQX9epquVGmgj8e9LTamm0epH1hX6yq/4j6RXK1JkOSeBqP+WtAN7
>74LAtsW3NP8g6zagx/kb
>=giYU
>-----END PGP SIGNATURE-----
>
>
>------------------------------------------------------------------------------
>What NetFlow Analyzer can do for you? Monitors network bandwidth and
>traffic
>patterns at an interface-level. Reveals which users, apps, and
>protocols are 
>consuming the most bandwidth. Provides multi-vendor support for
>NetFlow, 
>J-Flow, sFlow and other flows. Make informed decisions using capacity
>planning
>reports.http://sdm.link/zohodev2dev
>_______________________________________________
>User-mode-linux-devel mailing list
>User-mode-linux-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
------RG0RDWGJ5O9LCSE8O8PR3JVQD6SI41
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html><head></head><body>I have some patches which bring network performance to &gt; 3gbit for a single core virtual router/firewall/net device, need to find time to get them up to date and resubmit.<br>
Some disk is improvements too.<br><br><div class="gmail_quote">On 20 July 2016 19:04:28 CEST, Ritesh Raj Sarraf &lt;rrs@debian.org&gt; wrote:<blockquote class="gmail_quote" style="margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<pre class="k9mail">-----BEGIN PGP SIGNED MESSAGE-----<br />Hash: SHA512<br /><br />Hello Jeff, Richard and the UML Team.<br /><br />Me and Mattia are maintainers for UML in the Debian Distribution.<br /><br />Recently, during a refresh of the package, we realized that the User Mode Linux<br />website, which hosts useful documentation, doesn't seem to have been updated in<br />years.<br /><br />The documentation which still is active and useful[1] is marked as "old" on the<br />website.<br />The wiki [2] on the other hand, points to a link with no content at all.<br /><br />Could you please share on what the roadmap and future plans for UML are?<br />And for the documentation on the old site, do you have it in a Source Markup<br />Language? What we've used now is a dump of the website from [1]<br /><br />[1] <a href="http://user-mode-linux.sourceforge.net/old">http://user-mode-linux.sourceforge.net/old</a>/<br />[2] <a
href="http://uml.harlowhill.com">http://uml.harlowhill.com</a>/<br /><br />- -- <br />Ritesh Raj Sarraf | <a href="http://people.debian.org/~rrs">http://people.debian.org/~rrs</a><br />Debian - The Universal Operating System<br />-----BEGIN PGP SIGNATURE-----<br /><br />iQIcBAEBCgAGBQJXj68dAAoJEKY6WKPy4XVpDEMQAJuzJVT9z2KMLYl+69RSe1wL<br />VHbrT23TPVEuIBMFPxpilSbJcTGAg9XA/WJ/h+xONzAQ14rKBsoJFAvPGkZHJHsf<br />aNSXNU4fI2EEPNoYCocZnQwbuReeI4up8BnIX9KxuSOmOJirbkC88YG9EfmmpjSG<br />Nm8nJFZdXa8psXz7zfxH1BZyMTWDwaqfKfxvwQmrA4s0FjUY8pL/2ggEggLRsClR<br />8lzxsvzs1Zt/1+wostGYCqXRfQBKfyHBUlrBBsI2GhxjEndZHQTkxR8iWCSzfAZg<br />mydkz1uEDyme3Op+rSOyRgO9DTlNdnczM9/6rL6Zs4CEDyy0Xowk0BZBTV0Bd3Bw<br />U5WvjgEEnyvGsmvSyY0wj7A+FdRWnlRJrCanRlPSLc1iuJAgebDDRyL7qmVIaW9Z<br />JJrOgH+NLo7Yer7xpOn7esChu7Gjw1kO6IFsD9xqMVsCy5ByPMPqpDrfL5SFhMPo<br />CycOalMupTjT4rRR9ocMF7XebCLIIxAT0Rvwvmyk4gbYryZZlT6pKDTe9XzmHgCN<br />EMs9t8kxle0hSDT+z2FE9w5/6b6cYbAALRe305n/Xy8GmGwA1bZ/xJC761JB+TlG<br
/>xq5jl94T9rhqQX9epquVGmgj8e9LTamm0epH1hX6yq/4j6RXK1JkOSeBqP+WtAN7<br />74LAtsW3NP8g6zagx/kb<br />=giYU<br />-----END PGP SIGNATURE-----<br /><br /><br /><hr /><br />What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic<br />patterns at an interface-level. Reveals which users, apps, and protocols are <br />consuming the most bandwidth. Provides multi-vendor support for NetFlow, <br />J-Flow, sFlow and other flows. Make informed decisions using capacity planning<br />reports.http://sdm.link/zohodev2dev<br /><hr /><br />User-mode-linux-devel mailing list<br />User-mode-linux-devel@lists.sourceforge.net<br /><a href="https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel">https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel</a><br /></pre></blockquote></div><br>
-- <br>
Sent from my Android device with K-9 Mail. Please excuse my brevity.</body></html>
------RG0RDWGJ5O9LCSE8O8PR3JVQD6SI41--



--===============1230614667475915847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity planning
reports.http://sdm.link/zohodev2dev
--===============1230614667475915847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1230614667475915847==--




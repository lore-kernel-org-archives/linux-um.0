Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CU5WA-000758-D3 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Nov 2004 07:45:18 -0800
Received: from [217.204.41.189] (helo=kula.newsnow.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CU5W6-0001S0-5r
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Nov 2004 07:45:18 -0800
Message-ID: <419A205F.7000107@praguespringpeople.org>
From: Struan Bartlett <struan@praguespringpeople.org>
MIME-Version: 1.0
Subject: uml-patch-2.4.27-1 not fixed Re: [uml-devel] 2.4.27 guest bug
	reconfirmed Re bug report [ 745826 ] run cat /dev/urandom
References: <418E5CA1.90308@praguespringpeople.org>
	<419737C6.3060904@praguespringpeople.org>
	<200411151821.11779.blaisorblade_spam@yahoo.it>
In-Reply-To: <200411151821.11779.blaisorblade_spam@yahoo.it>
Content-Type: multipart/alternative;
	boundary="------------030505070502050101040901"
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
Date: Tue, 16 Nov 2004 16:44:31 +0100
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------030505070502050101040901
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I've compiled and ran the test (below) on a virgin 2.4.27 kernel patched 
with uml-patch-2.4.27-1.bz2.

Result: the bug is still readily reproducible and _is not fixed_ in this 
patch.

P.S. Jeff Dike: if CONFIG_NETFILTER=y is set in .config, the patched 
kernel fails to compile.

Blaisorblade wrote:

>On Sunday 14 November 2004 11:47, Struan Bartlett wrote:
>  
>
>>I've now tested for this bug using a simplified methodology on the
>>latest patched-versions of the host (2.4.27 and 2.6.8) and guest (2.4.27
>>and 2.6.9).
>>    
>>
>>_New methodology_
>>    
>>
>>My Debian guest system raises two xterms at startup. On each I log in as
>>root. On one, I enter:
>>    
>>
>>while true; do echo >/dev/null; done
>>    
>>
>>On the second, I enter:
>>    
>>
>>cat /dev/urandom
>>    
>>
>>The devastating symptom: within 5 seconds the guest kernel has paniced
>>and exited with the message (below) "kernel BUG at sched.c:564!".
>>
>>_Findings_
>>    
>>
>>guest 2.4.27: patched with uml-2.4.27-bs1.patch and
>>uml-patch-2.4.24-1base.patch - no change; this bug is readily
>>reproducible and so IS NOT FIXED, regardless of whether the guest is run
>>on host 2.4.27 or 2.6.8
>>    
>>
>>_Conclusion_
>>
>>If such a simple pair of commands as this causes such devastating
>>consequences, it seems the 2.4.27 kernel sched.c line 564 needs to be
>>taken a look at - unless, that is, Jeff Dike's recent post about
>>uml-patch-2.4.27-1 "a nasty scheduler race fixed" addresses this bug.
>>    
>>
>I may be wrong, but I think I should have picked that patch into 2.4.27-bs1.
>
>I'll take a look at your report - there is one patch applied on 2.6 that 
>seemed unneeded on 2.4 until now - this may be reconsidered...
>  
>


--------------030505070502050101040901
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-15"
 http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
I've compiled and ran the test (below) on a virgin 2.4.27 kernel
patched with uml-patch-2.4.27-1.bz2.<br>
<br>
Result: the bug is still readily reproducible and <u>is not fixed</u>
in this patch.<br>
<br>
P.S. Jeff Dike: if CONFIG_NETFILTER=y is set in .config, the patched
kernel fails to compile.<br>
<br>
Blaisorblade wrote:
<blockquote cite="mid200411151821.11779.blaisorblade_spam@yahoo.it"
 type="cite">
  <pre wrap="">On Sunday 14 November 2004 11:47, Struan Bartlett wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I've now tested for this bug using a simplified methodology on the
latest patched-versions of the host (2.4.27 and 2.6.8) and guest (2.4.27
and 2.6.9).
    </pre>
  </blockquote>
  <blockquote type="cite">
    <pre wrap="">_New methodology_
    </pre>
  </blockquote>
  <blockquote type="cite">
    <pre wrap="">My Debian guest system raises two xterms at startup. On each I log in as
root. On one, I enter:
    </pre>
  </blockquote>
  <blockquote type="cite">
    <pre wrap="">while true; do echo &gt;/dev/null; done
    </pre>
  </blockquote>
  <blockquote type="cite">
    <pre wrap="">On the second, I enter:
    </pre>
  </blockquote>
  <blockquote type="cite">
    <pre wrap="">cat /dev/urandom
    </pre>
  </blockquote>
  <blockquote type="cite">
    <pre wrap="">The devastating symptom: within 5 seconds the guest kernel has paniced
and exited with the message (below) "kernel BUG at sched.c:564!".

_Findings_
    </pre>
  </blockquote>
  <blockquote type="cite">
    <pre wrap="">guest 2.4.27: patched with uml-2.4.27-bs1.patch and
uml-patch-2.4.24-1base.patch - no change; this bug is readily
reproducible and so IS NOT FIXED, regardless of whether the guest is run
on host 2.4.27 or 2.6.8
    </pre>
  </blockquote>
  <blockquote type="cite">
    <pre wrap="">_Conclusion_

If such a simple pair of commands as this causes such devastating
consequences, it seems the 2.4.27 kernel sched.c line 564 needs to be
taken a look at - unless, that is, Jeff Dike's recent post about
uml-patch-2.4.27-1 "a nasty scheduler race fixed" addresses this bug.
    </pre>
  </blockquote>
  <pre wrap=""><!---->I may be wrong, but I think I should have picked that patch into 2.4.27-bs1.</pre>
  <pre wrap="">I'll take a look at your report - there is one patch applied on 2.6 that 
seemed unneeded on 2.4 until now - this may be reconsidered...
  </pre>
</blockquote>
<br>
</body>
</html>

--------------030505070502050101040901--


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

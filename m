Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bhib5-00065z-1I for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jul 2004 22:34:27 -0700
Received: from letters.cs.ucsb.edu ([128.111.41.13])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bhib4-0004Nt-Mg for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jul 2004 22:34:26 -0700
Message-ID: <40EA39DC.5030409@cs.ucsb.edu>
From: "Lamia M.Youseff" <Lyouseff@cs.ucsb.edu>
MIME-Version: 1.0
Subject: Re: Please upgrade! (was: Re: [uml-devel] does O_DIRECT hinder greatly
	file reading performance but not writing??)
References: <40E51FF0.3020801@cs.ucsb.edu>
	<200407032128.40746.blaisorblade_spam@yahoo.it>
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit
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
Date: Mon, 05 Jul 2004 22:34:20 -0700
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body>
Hello All, Hi BlaisorBlade,<br>
I upgraded to 2.4.24-1um, but the same error still persist on the um..i.e.
the disk reads takes so long when used with the O_DIRECT flag !!<br>
Anybody has any explanation for that??<br>
<br>
Thank you,<br>
Lamia Youseff<br>
<br>
<br>
BlaisorBlade wrote:<br>
<blockquote type="cite"
 cite="mid200407032128.40746.blaisorblade_spam@yahoo.it">
  <pre wrap="">Alle 10:42, venerd&igrave; 2 luglio 2004, Lamia M.Youseff ha scritto:

  </pre>
  <blockquote type="cite">
    <pre wrap="">I am running UML 2.4.19 on top of kernel 2.4.25.  I have time output like
that (average of 20 runs) 
    </pre>
  </blockquote>
  <pre wrap=""><!---->Well, could you try upgrading it to 2.4.24-1um and retesting? That UML is old, 
buggy, and outdated.

  </pre>
</blockquote>
<br>
<pre class="moz-signature" cols="$mailwrapcol">-- 
..........................................................
: Lamia M.Youseff          :  <a class="moz-txt-link-abbreviated" href="mailto:lyouseff@cs.ucsb.edu">lyouseff@cs.ucsb.edu</a>       :
: Ph.D student             :  <a class="moz-txt-link-abbreviated" href="http://www.cs.ucsb.edu/~lyouseff">www.cs.ucsb.edu/~lyouseff</a>  :
: University of California,:                             :
: Santa Barbara (UCSB)     :                             :
:........................................................:
:                                                        :
: "There are no impossible dreams; there is just our     :
: limited perception of what is possible"                :
*:-.,_,.-:*'``'*:-.,_,.-:*'``'*:-.,_,.-:*'``'*:-.,_,.-:*'*</pre>
<br>
</body>
</html>



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

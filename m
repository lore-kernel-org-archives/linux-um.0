Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DfW3X-0004tR-Bo	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Jun 2005 21:51:15 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1DfW3V-0005WN-KD
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Jun 2005 21:51:15 -0700
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] [PATCH 3/5] UML - Clean up tt mode remapping of UML
	binary
References: <200506062008.j56K89YA008957@ccure.user-mode-linux.org>
	<20050607005958.GK29811@parcelfarce.linux.theplanet.co.uk>
	<200506070318.50734.blaisorblade@yahoo.it>
In-Reply-To: <200506070318.50734.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200506062346.44891.rob@landley.net>
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
Date: Mon, 6 Jun 2005 23:46:44 -0400
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Blaisorblade <blaisorblade@yahoo.it>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org

On Monday 06 June 2005 09:18 pm, Blaisorblade wrote:
> > > P.S: is it only me or you've sent about 20 copies of your last message?
> >
> > Headers?
>
> The Message-ID seem to match, so guess it's my Kmail (never seen such a
> problem, though).
>
> Message-ID: <20050606235321.GJ29811@parcelfarce.linux.theplanet.co.uk>
> References: <200506062008.j56K89YA008957@ccure.user-mode-linux.org>
> <200506070105.20422.blaisorblade@yahoo.it>

I got about 20 copies of that message too.  There's some kind of loop going 
through Intel's servers, the message headers are progressively longer 
variants of:

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
 Received: from lists-outbound.sourceforge.net (lists-outbound.sourceforge.net 
[66.35.250.225])
        by grelber.thyrsus.com (8.13.1/8.13.1) with ESMTP id j5727DMt031684
        for <rob@landley.net>; Mon, 6 Jun 2005 22:07:13 -0400
 Received: from projects.sourceforge.net (sc8-sf-list1-b.sourceforge.net 
[10.3.1.7])
        by sc8-sf-spam2.sourceforge.net (Postfix) with ESMTP
        id 2E0C5E4AF; Mon,  6 Jun 2005 17:46:15 -0700 (PDT)
 Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] 
helo=sc8-sf-mx2.sourceforge.net)
        by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
        id 1DfSDQ-0007UB-Rp
        for user-mode-linux-devel@lists.sourceforge.net; Mon, 06 Jun 2005 
17:45:12 -0700
 Received: from fmr19.intel.com ([134.134.136.18] helo=orsfmr004.jf.intel.com)
        by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
        id 1DfSDO-0003gl-Il
        for user-mode-linux-devel@lists.sourceforge.net; Mon, 06 Jun 2005 
17:45:12 -0700
 Received: from orsfmr101.jf.intel.com (orsfmr101.jf.intel.com [10.7.209.17])
        by orsfmr004.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 
2004/09/17 17:50:56 root Exp $) with ESMTP id j570j4TU027763;
        Tue, 7 Jun 2005 00:45:04 GMT
 Received: from orsmsxvs041.jf.intel.com (orsmsxvs041.jf.intel.com 
[192.168.65.54])
        by orsfmr101.jf.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 
2004/09/17 18:05:01 root Exp $) with SMTP id j570dvQF011113;
        Tue, 7 Jun 2005 00:44:50 GMT
 Received: from orsmsx332.amr.corp.intel.com ([192.168.65.60])
 by orsmsxvs041.jf.intel.com (SAVSMTP 3.1.7.47) with SMTP id 
M2005060617432614357
 ; Mon, 06 Jun 2005 17:43:35 -0700
 Received: from mail pickup service by orsmsx332.amr.corp.intel.com with 
Microsoft SMTPSVC;
         Mon, 6 Jun 2005 17:38:55 -0700
 Received: from orsmsxvs040.jf.intel.com ([192.168.65.206]) by 
orsmsx332.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
         Mon, 6 Jun 2005 17:11:03 -0700
 Received: from orsfmr100.jf.intel.com ([10.7.209.16])
 by orsmsxvs040.jf.intel.com (SAVSMTP 3.1.7.47) with SMTP id 
M2005060617110225137
 for <tom.l.nguyen@intel.com>; Mon, 06 Jun 2005 17:11:02 -0700
 Received: from orsfmr004.jf.intel.com (orsfmr004.jf.intel.com [10.7.208.20])
        by orsfmr100.jf.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 
2004/09/17 18:05:01 root Exp $) with ESMTP id j570B2qr012945
        for <tom.l.nguyen@intel.com>; Tue, 7 Jun 2005 00:11:02 GMT
 Received: from vger.kernel.org (vger.kernel.org [12.107.209.244])
        by orsfmr004.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 
2004/09/17 17:50:56 root Exp $) with ESMTP id j570AlTr014175
        for <tom.l.nguyen@intel.com>; Tue, 7 Jun 2005 00:11:02 GMT
 Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S261787AbVFGABn (ORCPT <rfc822;tom.l.nguyen@intel.com>);
        Mon, 6 Jun 2005 20:01:43 -0400
 Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbVFFX5w
        (ORCPT <rfc822;linux-kernel-outgoing>);
        Mon, 6 Jun 2005 19:57:52 -0400
 Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56209 
"EHLO
        parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
        id S261778AbVFFXwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2005 19:52:34 -0400
 Received: from viro by parcelfarce.linux.theplanet.co.uk with local (Exim 
4.43)
        id 1DfRPF-0002v4-Sq; Tue, 07 Jun 2005 00:53:21 +0100
 From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>


Rob


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

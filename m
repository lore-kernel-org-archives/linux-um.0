Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DGwXH-00032L-I7 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 31 Mar 2005 02:04:23 -0800
Received: from lon-del-01.spheriq.net ([195.46.50.97])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1DGwWy-0004nA-NS
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 31 Mar 2005 02:04:23 -0800
Received: from lon-out-02.spheriq.net ([195.46.50.130])
	by lon-del-01.spheriq.net with ESMTP id j2VA3qRc015711
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 31 Mar 2005 10:03:53 GMT
Received: from lon-cus-02.spheriq.net (lon-cus-02.spheriq.net [195.46.50.38])
	by lon-out-02.spheriq.net with ESMTP id j2VA3pBX009544
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 31 Mar 2005 10:03:51 GMT
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by lon-cus-02.spheriq.net with ESMTP id j2VA3kXQ014296
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=OK)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 31 Mar 2005 10:03:50 GMT
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D0678DA41
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 31 Mar 2005 10:03:45 +0000 (GMT)
Received: from zeta.dmz-ap.st.com (localhost [127.0.0.1])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7E209520C1
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 31 Mar 2005 10:03:45 +0000 (UTC)
Received: from mail1.sha.st.com (mail1.sha.st.com [10.94.100.2])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5F20413280
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 31 Mar 2005 10:03:43 +0000 (GMT)
From: Alex LIU <alex.liu@st.com>
Message-ID: <003501c535d8$e8574a50$90b3c68a@st.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Subject: [uml-devel] question about UML sigcontext in tt mode
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
Date: Thu, 31 Mar 2005 18:03:34 +0800
Content-Transfer-Encoding: 8bit
To: UML-dev <user-mode-linux-devel@lists.sourceforge.net>

Hi,all:

I have a question about the sigcontext in tt mode.The union uml_pt_regs is defined as below(in uml-2.6.7):

--------------------------------
union uml_pt_regs {
#ifdef UML_CONFIG_MODE_TT
	struct tt_regs {
		long syscall;
		void *sc;
	} tt;
#endif
#ifdef UML_CONFIG_MODE_SKAS
	struct skas_regs {
		unsigned long regs[HOST_FRAME_SIZE];
		unsigned long fp[HOST_FP_SIZE];
		unsigned long xfp[HOST_XFP_SIZE];
		unsigned long fault_addr;
		unsigned long fault_type;
		unsigned long trap_type;
		long syscall;
		int is_user;
	} skas;
#endif
};
-------------------------------------

Then why the tt.sc is defined as void while not as struct sigcontext? Thanks!

Alex 





-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/info/Sentarus/hamr30
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

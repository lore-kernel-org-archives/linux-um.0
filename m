Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC1FC61DA4
	for <linux-um@archiver.kernel.org>; Mon, 13 Mar 2023 21:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:
	Subject:To:From:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=K022WpWekpFNa8T82dUSidKVfLMAxjuVs9CIJa1DvOQ=; b=MiXQkjQrQ02CIU
	cgqlyN3J/3eRiwgFMOcmpVaF6QWfV6+9SfDmF2XFklHIx5zeVjP7TnOjpZBgBpHylMz0Fve+n0oY9
	1IYhPJ9lGIGbJr6gCVc53aTnWv1Ok+unLnH0alqSKjcEMcWnt85XWgy3ua7ssks/PdQJ/6wpVBBiG
	2WiS4ZBvOYOUyUYKaTpKI4iJ3ifnXHFhU8Zm/d4MaTcl/LbQl8T2HwP5SfomQPXUR827/f6CbhcIb
	WKyKH3iyfcIEUUXeKzsKv6dG+w+RT91sZaQ8AM44uvcqxmL9g5u1B7x6jWRj4qE6T/Nq3h/wgGYDC
	3hZjLUeZzDmZ17eS7dBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbq6b-0080I0-Du; Mon, 13 Mar 2023 21:53:21 +0000
Received: from [103.30.145.160] (helo=defaultworkshop.klidefectmanagement.com.novalocal)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbq6Y-0080GL-7L
	for linux-um@lists.infradead.org; Mon, 13 Mar 2023 21:53:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=asda.co.uk;
	s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
	Subject:To:From:Reply-To:Sender:Cc:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=fKhRvR45aZWdHK0AxXU1+nUsFLFdO4HClrFkXcJUaJw=; b=J
	5zI6SuH/3rTEyKV9SSw731k2Mdnc3sLZCwtj//vPo7FSF0+DEhMYHxda1OebGsGW0gXD3Hkqj6mus
	vPRokE+AyJztkBwX1lhlsaiuA9fSO4mi8DDBPnouCanovN+zmVJ14A0ekgrPD/u7kgL6iubZLaSox
	Rz+zG3wYP9eAC0q4=;
Received: from ec2-52-11-215-80.us-west-2.compute.amazonaws.com ([52.11.215.80] helo=asda.co.uk)
	by defaultworkshop.klidefectmanagement.com.novalocal with esmtpa (Exim 4.94.2)
	(envelope-from <sales1@asda.co.uk>)
	id 1pbm0N-0006F5-Nu
	for linux-um@lists.infradead.org; Tue, 14 Mar 2023 00:30:40 +0700
From: ASDA Stores Limited <sales1@asda.co.uk>
To: linux-um@lists.infradead.org
Subject: First quarter procurement order/enquiry
Date: 13 Mar 2023 17:30:38 +0000
Message-ID: <20230313152049.F6A463E2AD8E40D2@asda.co.uk>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230313_145318_626586_CD798A90 
X-CRM114-Status: UNSURE (  -0.82  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Reply-To: sales@asda-c.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Dear linux-um
I'm a procurement manager  with ASDA Group (the owners of ASDA 
Stores) and your company product has caught our interest. 
Therefore, we request you send
list and prices of your hot selling items (products) for our 
evaluation/pick.

Soon as we receive your reply, we shall send you our company 
profile and buying proposal. You can also check our website below 
for detailed info of our purchase area and trading capacity.

Your immediate response E-mail:  sales@asda-c.com   shall be 
appreciated.

Best Wishes

Ms Stelle Montgomery
Purchasing Dept.
ASDA Stores Limited
Tel:  +44 7418367220
WhatsApp: + 44-7502985874
Website: www.asda.com

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

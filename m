Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1794EC3DA49
	for <linux-um@archiver.kernel.org>; Tue, 30 Jul 2024 13:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=e2sFKzSUhD2Go8cjq+Gl38soHWXaUB6xVof3FjJbHLg=; b=Jptk+uF49f6mqPP5ZmEU9O68Zx
	oIEBQW8qfeJrv38k3EOtrTy/AwaaEF9cO3BV8slLti8vIZHR8M4eqU3YZ1ENIwszaMaCurH0SDVXg
	mvBqbDoNskR7ris3JuT8Ns1RyuSmSC3Vxh6g/HxrZgjB5i9nVBdvx8+42Z1NhOcyGj3Zb8y/F0vXl
	Pv59G75qEy6oAZGQiZnj8+oxaj8jkSTXPFXEugC/lGWfBMHeQ8CWXG2pysuF+ccp3t5t6KfQDPtrc
	tCzecUJuCBOVPPrKWviNLW+gvgZqsRrkryWciWTwHOYRKRuqDktO3trwbPbIchn2z/S5JeBJ/OUBc
	6gvhFmEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYnJj-0000000FMG2-3Pt6;
	Tue, 30 Jul 2024 13:55:07 +0000
Received: from mail.virtlab.unibo.it ([2001:760:2e00:f0a1::32])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYnJf-0000000FMCg-0fhj
	for linux-um@lists.infradead.org;
	Tue, 30 Jul 2024 13:55:05 +0000
Received: from cs.unibo.it (94-33-52-139.static.clienti.tiscali.it [94.33.52.139])
	by mail.virtlab.unibo.it (Postfix) with ESMTPSA id CAEF51C008F;
	Tue, 30 Jul 2024 15:54:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1722347686;
	bh=J1QsODZtr1Nm1WLMzL/+F/Sqd858SHwCNIwAH+zGj6E=;
	h=Date:From:To:Cc:Subject:From;
	b=dUK5GIDvY0T8/5it+IMCTHQenAFKIbkUR2bF9CUkpSG1WjDOSQlqZoEv3KwPPo9aD
	 N7rBG85V1L5Tmp3mxRN7K8fAhFseFtiI0kCHMaP/c7a0bPGFB0Xy42lm9aWvHhmzw0
	 Ll6l1ur0QNdJNOl96WH20AS4ufNXXxLDAcY2hJjs=
Date: Tue, 30 Jul 2024 15:54:45 +0200
From: Renzo Davoli <renzo@cs.unibo.it>
To: linux-um@lists.infradead.org
Cc: luca.bassi14@studio.unibo.it, davide.berardi@unimercatorum.it
Subject: [PATCH 0/2] VDE support as a vector 'transport
Message-ID: <ZqjwpbXrxtHc3Ulh@cs.unibo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240730_065504_047051_758D928B 
X-CRM114-Status: UNSURE (   8.85  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Virtual Distributed Ethernet (VDE) is a project whose main goal is to provide a
highly flexible support for virtual networking [1].

Common usages of VDE include fast prototyping and teaching.
Some Universities use UML and VDE in their courses:
University of Bologna: "Virtual System Design"
University of Modena and Reggio Emilia: "Networking"
University Paris 13: prof.Saiu and Loddo implemented "Marionnet" [6].
(based on UML and VDE).
Denison University Columbus OH, USA (prof Goldwweber), 
Unimercatorum (prof. Davide Berardi)...
and maybe many others I don't remember or I have never heard of.

The support for VDE currently in user-mode linux is quite dated.

I am proposing a new support for VDE as a 'transport' of the vector module.

When vdeplug4[1,2] is installed on the host running UML, vde 'transport' enables several
virtual networking implementations.

A very partial list includes:

linux ... vec0:transport=vde,vnl=tap://tap0
   use tap0
linux ... vec0:transport=vde,vnl=slirp://
   use slirp
linux ... vec0:transport=vde,vnl=vde:///tmp/switch
   connect to a vde switch
scp sshlirp-x86_64 remote.host:/tmp/sshlirp
linux ... vec0:transport=\"vde,vnl=cmd://ssh remote.host //tmp/sshlirp\"
   connect to a remote slirp (instant VPN: convert ssh to VPN, it requires [3])
linux ... vec0:transport=vde,vnl=vxvde://234.0.0.1
   connect to a local area cloud (all the UML nodes using the same multicast address running
   on hosts in the same multicast domain (LAN) will be automagically connected together to a virtual LAN.

The same vnl (virtual network locator) can be used to configure virtual interfaces for
qemu-systems/kvm, virtualbox, vdens (vde namespaces) [4], lxc [5] ... creating
virtual networks of heterogeneous nodes.

This new VDE support for UML does not need to link the libvdeplug library when compiling
UML (it uses a helper process).
When UML using vec0:transport=vde runs on a host where vdeplug4 is not installed, simply
a "no such file or directory" error message is emitted at run time.

	renzo 

[1]: https://github.com/rd235/vdeplug4
[2]: https://wiki.virtualsquare.org/#/tutorials/vdebasics
[3]: https://github.com/virtualsquare/sshlirp
[4]: https://github.com/rd235/vdens
[5]: https://github.com/virtualsquare/vdelxc
[6]: https://marionnet.org/

 Renzo Davoli(2):
	 vector_user: add VDE support
	 user_mode_linux_howto_v2: add VDE vector support in doc

 .../virt/uml/user_mode_linux_howto_v2.rst          | 37 ++++++++++
 arch/um/drivers/vector_user.c                      | 83 ++++++++++++++++++++++
 2 files changed, 120 insertions(+)



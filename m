Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E0BC982EA
	for <linux-um@archiver.kernel.org>; Mon, 21 Sep 2026 02:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z/1dyv75kvDtXna7My+DxwKsoa7QIaIFxsslk0GYF3w=; b=R9blJHvgOz0/1Fuu2muBLGbY+S
	uK5g4lwI8Vs+MAD8VlxAdOjlRJW20nejTcrdJfaVRMZbf4Px2Bw6+8smBrfODhYuh6bKZ4Q1sR6i1
	8TCR+7rWWvua9hjsd0xvc5ZV2oSCK8+5lsoOJ5xO5wV+tLoFXZxINSX/wcigYE9aJfOjg40roTdXX
	/vDS6Bv+SG+Vsc7oRnGQbo4XqHDk5W8pk7C6MFNJEOIPqV+fSqBafhx5wQd/Bu/+Eouo4aZMC6MwJ
	TQZgWh+gTC4nfVDCHzyGd8TBBPwVm8TLHUBhCJAHoK+AQ/1L5E4xXt4QH/o+lrai0VCHMlbF3M4dL
	0sRXcOUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8UAD-00000000kMd-3sYX;
	Mon, 21 Sep 2026 02:53:53 +0000
Received: from mail-qk2-x10.google.com ([2607:f8b0:4864:34::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8UAA-00000000kLy-3cBr
	for linux-um@lists.infradead.org;
	Mon, 21 Sep 2026 02:53:52 +0000
Received: by mail-qk2-x10.google.com with SMTP id d75a77b69052e-53122c5bbb4so30294461cf.2
        for <linux-um@lists.infradead.org>; Sun, 20 Sep 2026 19:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789959229; x=1790564029; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z/1dyv75kvDtXna7My+DxwKsoa7QIaIFxsslk0GYF3w=;
        b=IOhowB+92wseXIdY+Bokyt7ob7wZ4/Qo348xybrOdR14qJFTTCvar1+LPNorBLSyb7
         nufvkhjna9djyU+tcAbB2yqVlPUnXn23rdFAnpqjDb5Ofpldne6DqAigu5fJpmnmrKEd
         SV9Bqi3j2LXFcF5dx68aXXIJ847mhLAR2rbQEIee61x3t9prfKskp5fSdEllBPVfSfty
         6+k/qUZXb2B6T0ibDL//wZMAgQPgs6VbeZJr2i9wtU7O6zTsWUE2q7t5mMlU9dVmDOBG
         67nt/mushvHMt8nY+ZK9HdgMEkvQ0t+9mkCkCX7CCTdfm0AkrgVaqxFGyaj2Nwq93XLR
         +R2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789959229; x=1790564029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z/1dyv75kvDtXna7My+DxwKsoa7QIaIFxsslk0GYF3w=;
        b=DMiMEscKYKagKoRVRIrxKWN32UkLDq+y15hcPnSwzE50KnVikYgDG0wkpiVaxqJdVh
         8OsOsHfyp044zts9TnjEUeF2iPj4UXXv3rpuTUmWbZMJPM2YC2dkY+yYgmy6kCOI05sI
         JnlZPrSYBpQnksoH1f1E3OrwM3WdXBkcnktGsp9Pvksq+geCkIXeHv1DhrUe1P1IKhev
         bawxoZXQIGsPJa4QVMrEKov3rpgt6fhzSy+R8t/QBlpkOMgqODLhBkL4SFKor82ZrNAp
         1lAs5y7cVoYV9tHLYCwobqsO5TDyHwaoXLSYV4trZZhDUy2OOc/WWS8s1lHwGzGlSTih
         RGKw==
X-Forwarded-Encrypted: i=1; AKwUvBz7tqW1gITGtntwByOFaOkdkQgqua0BOPEQ0sMPDk4qnVAoJp9CR+gsKLa9iwQU1DmwvWYuT5ORGA==@lists.infradead.org
X-Gm-Message-State: AFuF++noeS0t5tRfoXkzYoLk1kz+218iGo2GTTF2Bmj/70Abr6zAXXic
	ySpg0snbQ6LDyA+wKRZnO/as/1v8dXQUXv71ZBNv5fbQy7sxNas0qrmd
X-Gm-Gg: AYBFou3KIIOgiQ+5xw7eLJbtfgbCHK+BotDRtM03UOafAhRWkAjCE1BbuWgaoQdqpt4
	6aYgyJQfUAeLmxFjYz+Gt8Id82LwNoajZskKP6knllRTle+Cf23964gOwAhsrSpHGVs1kXrdGIp
	YQwyRsL2bDH+4v3/uEE66LAE5kM2+m5fYyLayl/080QS/Jt/ReSxRfjedn9wunY0Xe1A51wBKh6
	5j1gZL2Y1NqzbNtA2gAGJjWIe2b0/eojhZ1+P9oFfcVylq4f3wM8fhNEa/kToqGlBrraAHLmkP+
	EGL9g64Hsoafpr7GmYzjcnATcMnK9C8CR7WPRTM3B9vuv8yqulxAXudY2esD2W1UVPe2bC1U3EJ
	eiihvwTadQrnuXbexVNOWUC8Lz3rKGH8utWFv/4SFLoxiAel9ke2jduqCrn65vOF3xYTmQAfof4
	Dn8etBalu3PijMt8IxKFTXe1dbxO7bnst9KPT+hDhU911oK+DI+VFX1ZVv6Qzxg2P/k1x9Au0qB
	PZI6UkS2TDuA4u4FXGqMguseh3xe8VXPXON32zb3/xUn57SmUbbpCkwI6QbWmD6vO2Vz/4C
X-Received: by 2002:a05:620a:3187:b0:939:d913:9a74 with SMTP id af79cd13be357-93bf56ef696mr809392485a.46.1789959228703;
        Sun, 20 Sep 2026 19:53:48 -0700 (PDT)
Received: from localhost.localdomain ([2601:155:4200:2c80:64b9:5e22:f77c:324e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93bedb3de58sm528732785a.37.2026.09.20.19.53.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Sep 2026 19:53:48 -0700 (PDT)
From: Paulos Yibelo <habte.yibelo@gmail.com>
To: netdev@vger.kernel.org
Cc: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	mst@redhat.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	andrew+netdev@lunn.ch,
	pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	razor@blackwall.org,
	idosch@nvidia.com,
	dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-um@lists.infradead.org,
	virtualization@lists.linux.dev,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v5 0/2] net: prevent partial checksums from modifying network headers
Date: Sun, 20 Sep 2026 22:53:39 -0400
Message-ID: <20260921025341.44846-1-habte.yibelo@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260920004733.6473-1-habte.yibelo@gmail.com>
References: <20260920004733.6473-1-habte.yibelo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_195350_932283_04C4906E 
X-CRM114-Status: UNSURE (   9.09  )
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

A virtio-net header can supply CHECKSUM_PARTIAL metadata whose checksum
start resolves inside the network header after link-layer removal.
Software checksum completion can then modify header bytes which the stack
has already parsed.

Patch 1 validates the checksum start against an explicit data-relative L3
origin. It covers TUN/TAP, virtio-net, AF_PACKET, UML, nested VLAN
headers, and tunnel metadata. It does not rely on skb header state which
may not yet be established.

Patch 2 independently validates the checksum start against the parsed
IPv4 or IPv6 header length in all four IP fragmentation implementations
which complete partial checksums.

The v4 Sashiko findings were correct. Patch 1 used
skb_network_offset() before all receive callers had established it.
Patch 2 compared a signed checksum offset with an unsigned IPv4 header
length. This revision fixes both findings and covers the corresponding
bridge and IPv6 fragmentation paths.

Validation included strict checkpatch, focused x86 and UML W=1 builds,
an offset-boundary model, and application of the exact mail series to the
stated base.

Changes in v5:
- Pass an explicit data-relative L3 origin through the virtio-net
  converter and audit every in-tree caller.
- Parse Ethernet and nested VLAN headers without mutating skb header
  state.
- Propagate virtio-header conversion failures in UML.
- Keep the IPv4 comparison signed and add matching parsed-header checks
  to the IPv4/IPv6 output and bridge-netfilter fragmentation paths.
- Drop Michael S. Tsirkin's Acked-by and David Ahern's Reviewed-by tags
  because both patches changed materially.

Link: https://lore.kernel.org/netdev/20260920004733.6473-1-habte.yibelo@gmail.com/

Paulos Yibelo (2):
  net: validate virtio checksum start after network header
  ip: reject partial checksums covering network headers

 arch/um/drivers/vector_transports.c        | 10 ++-
 drivers/net/tun_vnet.h                     | 28 +++++++-
 drivers/net/virtio_net.c                   |  8 ++-
 include/linux/virtio_net.h                 | 76 ++++++++++++++++++----
 net/bridge/netfilter/nf_conntrack_bridge.c | 21 ++++--
 net/ipv4/ip_output.c                       | 23 +++++--
 net/ipv6/ip6_output.c                      | 12 +++-
 net/ipv6/netfilter.c                       | 12 +++-
 net/packet/af_packet.c                     |  6 +-
 9 files changed, 157 insertions(+), 39 deletions(-)


base-commit: 1e24c4f2ee44be0eee94092b5d13cbdb4bdf0d60
-- 
2.46.0


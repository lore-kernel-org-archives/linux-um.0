Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47633CD342F
	for <linux-um@archiver.kernel.org>; Tue,  3 Sep 2024 06:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VgrxN144iUPf7NqeoMOyzsSN98GEfqKoLsawzlynxPg=; b=nxQVYm6XiZq9bTq+4zZ9tYgenB
	FOt2RNP89/JzAiVU2Oe1uISnqu6c32K7inD/XvfdZY9mZYHpoBzbj5Dbz0yLsvrqLhb+BJnDjHDYw
	LZEgLmZQPIaYxA9DFLn8ocxRNVXP/hotaFUWVyg1hN9zoNyHqQDrp1n3VSHA3RL+gFMxtaGMuqxqR
	qgrvGXcZXQ3CzA5hmOLdxowfifL59kmVaS29FauyjaMQ/oRmOXb/I3H3NrN+7RIfaQw2P9so96Wu3
	Gpp2xnId4fKqRlLAEA/7QUE7uletKTW3T/uu+nfRP7iNiqFVRTKHYKrsv5u1A/GFN2ec1bGfKhp19
	jwHERy8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slN0y-0000000GSrU-2lVz;
	Tue, 03 Sep 2024 06:27:44 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slN0v-0000000GSqa-1u7V
	for linux-um@lists.infradead.org;
	Tue, 03 Sep 2024 06:27:43 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 482MmnT9025891;
	Tue, 3 Sep 2024 06:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:in-reply-to:references:date:message-id
	:mime-version:content-type; s=pp1; bh=VgrxN144iUPf7NqeoMOyzsSN98
	GEfqKoLsawzlynxPg=; b=rzESbfHimjo981rF1eOvgpMSjsCQ2UXY78JmMhDEPZ
	DPh07gQoAfNtgrqCnJFv+HngQ73My+guTlInZU4UAvE+Dm9dcfsYpQEIqRqoVG6I
	obVtiqyrCd8ZtLNynhBiS1xKvLMAi/spun5PMu9Eab4stcoNMpzU0EqMEfHF9k64
	+Lwt5vXL3GQWmcwF7+U+6eOVKzqSx/n6WbnE3sku4HNati9Ia2vVLoEPV1PxeuvG
	3fui9eN9a0KkNJJxBS5E1cd0jLPmZSXe5AuC2X3sdunUJeNgYrgy4e73/Bna0Inl
	PYj52ozWBoOg+tVNxtsqs4KH9vbGLWVO9WCW8G0uWdcA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41brkqmhru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 06:27:23 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4836RNUi007387;
	Tue, 3 Sep 2024 06:27:23 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41brkqmhrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 06:27:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4832HPjd012052;
	Tue, 3 Sep 2024 06:27:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41cegpse6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 06:27:22 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4836RKVJ14483918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Sep 2024 06:27:20 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1289B2004D;
	Tue,  3 Sep 2024 06:27:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BD9820040;
	Tue,  3 Sep 2024 06:27:19 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  3 Sep 2024 06:27:19 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor
 <nathan@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu,
        jeffxu@google.com, Liam.Howlett@oracle.com,
        linux-kernel@vger.kernel.org, npiggin@gmail.com, oliver.sang@intel.com,
        pedro.falcato@gmail.com, linux-um@lists.infradead.org,
        linux-s390@vger.kernel.org,
        Ravi Bangoria
 <ravi.bangoria@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct
 vm_special_mapping
In-Reply-To: <CAHk-=wjD0XLhkzou89J-TK=L6B88pFoNYxN1uTWRQB3U5Czywg@mail.gmail.com>
	(Linus Torvalds's message of "Mon, 2 Sep 2024 14:02:56 -0700")
References: <20240812082605.743814-1-mpe@ellerman.id.au>
	<20240819185253.GA2333884@thelio-3990X>
	<yt9dy149vprr.fsf@linux.ibm.com>
	<20240902134953.e834bc2e57d36b1d3b1397e4@linux-foundation.org>
	<CAHk-=wjD0XLhkzou89J-TK=L6B88pFoNYxN1uTWRQB3U5Czywg@mail.gmail.com>
Date: Tue, 03 Sep 2024 08:27:19 +0200
Message-ID: <yt9dr0a1uu9k.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9aSqu6fFfWss73YgKp0gBlzFQVIXapXn
X-Proofpoint-ORIG-GUID: OxhEA4e_rV3dfcm0C7DWi8uVqyGWdHzl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_06,2024-09-02_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 mlxscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=970 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409030046
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240902_232741_639136_E6DA8E83 
X-CRM114-Status: GOOD (  17.95  )
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

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, 2 Sept 2024 at 13:49, Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> uprobe_clear_state() is a pretty simple low-level thing.  Side-effects
>> seem unlikely?
>
> I think uprobe_clear_state() should be removed from fork.c entirely,
> made 'static', and then we'd have
>
>         area->xol_mapping.close = uprobe_clear_state;
>
> in __create_xol_area() instead (ok, the arguments change, instead of
> looking up "mm->uprobes_state.xol_area", it would get it as the vma
> argument)
>
> That's how it should always have been, except we didn't have a close() function.
>
> Hmm?

Indeed, that's much better. I'll prepare a patch.

Thanks!


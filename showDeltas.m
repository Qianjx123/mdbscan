function showDeltas(rhos, deltas)%数据点的局部密度数组，数据点的距离（与比自己密度大的点的距离的最小值）数组
%     subplot(2,2,2);
    tt = plot(rhos(:), deltas(:), 'o', 'MarkerSize', 3, 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k');
%     text = strcat('max rho: ', num2str(max(rhos)), ', delta: ', num2str(max(deltas)));
%     title (text, 'FontSize', 15.0);
%画出密度-距离二维图
    xlabel ('\it \rho');
    ylabel ('\it \delta');
end